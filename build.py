#!/usr/bin/env python3
# coding=utf-8
# -*- coding: utf-8 -*-

"""
All imports
"""
# Argument parsing
import argparse
# Proper regular expression building and matching
import re
# OS specific things like file handling
import os
# Handle the current build time in the final document
import datetime
# Nicer way of handling paths in python
import pathlib


def build():
    """
    This is the main function that builds the given file
    :return:
    """
    parser = argparse.ArgumentParser(description='Build the given TeX class.')

    parser.add_argument('cls', metavar='c', nargs='+', type=str,
                        help='LaTeX class to compile')

    parser.add_argument('-d', '--dest', dest='destination', type=str,
                        help='Set build destination folder.', default='build', action='store')

    # Parse the arguments given
    args = parser.parse_args()

    # Loop over each given cls file
    [process_file(f, dest=args.destination) for f in args.cls]


def process_file(f, dest='build'):
    """
    Process the given file
    :param str c: Filename of the file to process
    :param str dest: Destination directory name or path
    :return void:
    """
    # Open the source file
    ps = pathlib.Path(f).absolute()
    # Open the target file
    pd = pathlib.Path(dest + os.sep + ps.name).absolute()

    # Open the file
    try:
        with ps.open('r', encoding='utf-8') as s:
            # Read the whole file
            lns = s.readlines()

            # Then process all lines
            cnt = process_lines(lns)

            # Check if the target directory of the current file exists
            if not pd.parent.exists():
                # If not, create the directory first
                os.makedirs(pd.parent.absolute())

            # Write the content to the new target file
            pd.write_text(''.join(cnt), encoding='utf-8')
    except BaseException as err:
        raise ReferenceError('Error processing file \'{}\''.format(f)) from err


def process_lines(lns, replace_inc=None, replace_time=None):
    """
    Process lines of the given file
    :param list lns: An array of file lines
    :return str: The processed file content
    """

    # Loop over each line of the file and return the new list
    return [process_line(l, replace_inc, replace_time) for l in lns]


def process_line(l, replace_inc=None, replace_time=None):
    """
    Process a single line of text
    :param str l: The line to process and look for \input, \include, or \filedate
    :param re replace_inc: Regular expression to use to match the line of \include or \input
    :param re replace_time: Regular expression to use to match the line of \filedate
    :return str: The processed or original line
    """
    # Build the replacers if not given
    if replace_inc is None:
        replace_inc = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')
    if replace_time is None:
        replace_time = re.compile('\\\\filedate\\{(?P<filedate>.*)\\}')

    # Search for an include directive in the current line
    inc_found = replace_inc.search(l)
    # Search for a filedate directive in the current line
    time_found = replace_time.search(l)

    # Found an include directive to replace?
    if inc_found:
        # Get the file that should be injected
        inc_file = pathlib.Path('src' + os.sep + inc_found.group('incfile') + '.tex')

        # If the file exists, then process it
        if inc_file.exists():
            return ''.join(process_lines(inc_file.open('r', encoding='utf-8').readlines(), replace_inc, replace_time))
    # Found a filedate directive to replace
    elif time_found:
        return l.replace(time_found.group('filedate'), datetime.datetime.utcnow().strftime('%Y/%m/%d'))

    # Return the current line
    return l


if __name__ == '__main__':
    build()
