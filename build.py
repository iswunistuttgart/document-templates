#!/usr/bin/env python3
# coding=utf-8

import glob
import os
import re

dir_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(dir_path)

p = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')

def process_file(the_file):
    lines = []

    for idx, line in enumerate(the_file):
        lines.append(process_line(line))

    return lines

def process_line(the_line):
    global p, dir_path

    m = p.search(the_line)

    if m :
        inc_file = m.group('incfile')

        inc_path = os.path.join(dir_path, inc_file + '.tex')

        if os.path.isfile(inc_path):
            f = open(inc_path, 'r', encoding="utf-8")

            try:
                return ''.join(process_file(f)) + '\n'
            finally:
                f.close()

    return the_line

for file in glob.glob("src/*.cls"):
    source = open(file, 'r')
    target = open(file.replace('src/', ''), 'w')

    try :
        target.write(''.join(process_file(source)) + '\n')
    except Exception as e:
        print(e)
    finally:
        target.close()
        source.close()
