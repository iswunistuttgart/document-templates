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


def create():
    """
    This is the main function that finds all macros/commands in the given file(s)
    :return:
    """
    parser = argparse.ArgumentParser(description='Read custom macros/commands of the given LaTeX class(es).')

    parser.add_argument('files', metavar='f', nargs='+', action='store', type=str,
                        help='LaTeX file to trawl through')

    parser.add_argument('--output', dest='output', action='store', const=True, default=False, type=str,
                        nargs='?',
                        help='Write list to a markdown formatted file')

    # Parse the arguments given
    args = parser.parse_args()

    # Loop over each given file and get its included packages
    mcrs = [trawl_file(f) for f in args.files]

    # Write the output to either file or stdout
    write_output(args.files, mcrs, write=args.output)


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
    mcrs = []

    # Loop over each line of the file
    for l in f:
        p = trawl_line(l)

        if type(p) is list:
            mcrs.extend(p)
        elif p:
            mcrs.append(p)

    # Return the list of files
    return mcrs


def trawl_line(l):
    """
    Trawl a single line of text to find any RequirePackage or usepackage inside of it
    :param str l: Line to search
    :return None|str p: None if no macros, otherwise list of dicts
    """

    """
    If current line is an include/input, resolve that and scan this file
    """
    # Build the regular expression to match \input or \include
    re_inc = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')
    # Search for an include directive in the current line
    inc_found = re_inc.search(l)

    # Found an include file?
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
    re_smpl = re.compile('\%\s+\@sample\s+(?P<code>.*)\s*:\s*(?P<description>.*)', re.IGNORECASE)

    # Search for the package
    smpl_found = re_smpl.search(l)

    # Found a code sample fragment?
    if smpl_found:
        return {'code': smpl_found.group('code'), 'description': smpl_found.group('description')}

    # By default we will return none
    return None


def write_output(fs, mcrs, write=False):
    """
    Write output to file or stdout
    :param list fs: List of files processed
    :param list mcrs: List of list of packages per file
    :param bool|str write: If false, write to stdout, else write to given file name
    :return:
    """

    # Write to file or stdout?
    if type(write) is str:
        # Store the print content in here
        cnt = []

        # Add a nice file H1 heading
        cnt.append('\section*{List of Macros}')
        # Two empty lines
        cnt.append('')
        cnt.append('')

        # Loop over all files processed
        for k in range(0, len(fs)):
            # Add the file name of the processed file as H2 heading
            cnt.append('\subsection*{{{}}}'.format(pathlib.Path(fs[k]).stem))
            # Empty line between heading and list of packages
            cnt.append('')
            # Open table and tabular
            cnt.append('\\begin{longtable}{ p{0.29\linewidth} p{0.19\linewidth} p{0.48\linewidth} } \\toprule')
            cnt.append('  \\textbf{Code}\n      & \\textbf{Result}\n      & \\textbf{Description}\n    \\\\ \\midrule')
            cnt.append('    \\endhead')
            cnt.append('    \\midrule \\multicolumn{3}{r}{\smaller{Continued on next page}} \\\\ \\bottomrule')
            cnt.append('    \\endfoot')
            # cnt.append('  \\bottomrule')
            cnt.append('    \\endlastfoot')
            # List of packages formatted to be in a tabular environment
            cnt.extend(['  \latexinline|{}|\n      & ${}$\n      & {}\n    \\\\'.format(m['code'], m['code'], m['description']) for m in mcrs[k]])
            # Close tabular and table
            cnt.append('  \\bottomrule')
            cnt.append('  \\caption{{List of macros of the \\textinline|{}| class}}'.format(fs[k]))
            cnt.append('\\end{longtable}')
            # One empty line between previous file's package list and next file
            cnt.append('')

        # I love me some empty line at the end of files
        cnt.append('')
        # Joint the list of contents into a long string
        cnt = '\n'.join(cnt)

        # Open the "packages.md" file for writing
        p = pathlib.Path(write)

        # And write the content to a file
        p.write_text(cnt, encoding='utf-8')
    else:
        # Store the print content in here
        cnt = []

        # Create the content stdout friendly
        for k in range(0, len(fs)):
            # Add the filename of the file
            cnt.append('# {}'.format(pathlib.Path(fs[k]).stem))
            # List of macros formatted as "* {macro}: {description}"
            cnt.extend(['* {}: {}'.format(m['code'], m['description']) for m in mcrs[k]])
            # Empty line at the end of each package
            cnt.append('\n')

        # From list to string
        cnt = '\n'.join(cnt)

        # And write to stdout
        print(cnt)


if __name__ == '__main__':
    create()

