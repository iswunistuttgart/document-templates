#!/usr/bin/env python3
# coding=utf-8

# Argument parsing
import argparse
# Proper regular expression building and matching
import re
# OS specific things like file handling
import os
# Nicer way of handling paths in python
import pathlib


def collect():
    """
    This is the main function that finds all packages in the given file
    :return:
    """
    parser = argparse.ArgumentParser(description='List packages of the given LaTeX class(es).')

    parser.add_argument('files', metavar='f', nargs='+', action='store', type=str,
                        help='LaTeX file to trawl through')

    parser.add_argument('--output', dest='output', action='store', const=True, default=False, type=str,
                        nargs='?',
                        help='Write list to a markdown formatted file')

    # Parse the arguments given
    args = parser.parse_args()

    # Loop over each given file and get its included packages
    pkgs = [trawl_file(f) for f in args.files]

    # Write the output to either file or stdout
    write_output(args.files, pkgs, write=args.output)


def trawl_file(f):
    """
    Trawl the given file for packages
    :param str f: Filename of the file to process
    :return void:
    """
    # Open the source file
    ps = pathlib.Path(f)

    # Open the file
    try:
        with ps.open('r', encoding='utf-8') as s:
            # Process the file
            return trawl_lines(s)
    except BaseException as err:
        raise ReferenceError('Error processing file \'{}\''.format(f)) from err

    return []


def trawl_lines(f):
    """
    Process lines of the given file
    :param file f: A file object to read through
    :return str: The processed file content
    """
    pks = []

    # Loop over each line of the file
    for l in f:
        p = trawl_line(l)

        if type(p) is list:
            pks.extend(p)
        elif p:
            pks.append(p)

    # Return the list of files
    return pks


def trawl_line(l):
    """
    Trawl a single line of text to find any RequirePackage or usepackage inside of it
    :param str l: Line to search
    :return None|str p: None if no package, otherwise package name
    """

    """
    If current line is an include/input, resolve that and scan this file
    """
    # Build the regular expression to match \input or \include
    re_inc = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')
    # Search for an include directive in the current line
    inc_found = re_inc.search(l)

    # Found an include directive to scan into?
    if inc_found:
        # Get the file that should be trawled
        inc_file = pathlib.Path('src' + os.sep + inc_found.group('incfile') + '.tex')

        # If the file exists, then process it
        if inc_file.exists():
            return trawl_file(inc_file)

        return None

    """
    Plain line of text, so scan this line
    """
    # Regular expression to match either \usepackage or \RequirePackage
    re_pkg = re.compile('\\\\(usep|RequireP)ackage(?P<options>\[\w+=\ \])?\\{(?P<package>\w+)\\}', re.IGNORECASE)

    # Search for the package
    pkg_found = re_pkg.search(l)

    # Found an include directive to replace?
    if pkg_found:
        return pkg_found.group('package')

    # By default we will return none
    return None


def write_output(fs, pks, write=False):
    """
    Write output to file or stdout
    :param list fs: List of files processed
    :param list pks: List of list of packages per file
    :param bool|str write: If false, write to stdout, else write to given file name
    :return:
    """

    # Write to file
    if type(write) is str:
        # Store the print content in here
        cnt = []

        # Add a nice file H1 heading
        cnt.append('# List of Packages')
        # Two empty lines
        cnt.append('')
        cnt.append('')

        cnt.append('This is a comprehensive, semi automatically generated list of packages loaded by the respective LaTeX class files. Each package is linked to CTAN, but not every package has a dedicated package site like e.g., amssymb. So don\'t be surprised if you\'re getting a 404 ;)')

        # Loop over all files processed
        for k in range(0, len(fs)):
            # Add the file name of the processed file as H2 heading
            cnt.append('## {}'.format(pathlib.Path(fs[k]).stem))
            # Empty line between heading and list of packages
            cnt.append('')
            # List of packages formatted to be an unnumbered list in markdown
            cnt.extend(['  * [{}](https://ctan.org/pkg/{})'.format(p, p) for p in sorted(pks[k])])
            # One empty line between previous file's package list and next file
            cnt.append('')

        # I love me some empty line at the end of files
        cnt.append('')
        # Joint the list of contents into a long string
        cnt = '\n'.join(cnt)

        # Open the "packages.md" file for writing
        p = pathlib.Path(write)

        # Make sure we have the directory of the containing file, too
        p.parent.absolute().mkdir(parents=True, exist_ok=True)

        # And write the content to a file
        p.write_text(cnt, encoding='utf-8')
    else:
        # Store the print content in here
        cnt = []

        # Create the content stdout friendly
        for k in range(0, len(fs)):
            # Add the filename of the file
            cnt.append('# {}'.format(pathlib.Path(fs[k]).stem))
            # List of packages formatted as "* {package}"
            cnt.extend(['* {}'.format(p) for p in sorted(pks[k])])

        # From list to string
        cnt = '\n'.join(cnt)

        # And write to stdout
        print(cnt)


if __name__ == '__main__':
    collect()
