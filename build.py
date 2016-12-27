#!/usr/bin/env python3
# coding=utf-8

import glob
import os
import re
import shutil

dir_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(dir_path)

p = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')

def process_file(the_file):
    lines = []

    for line in the_file:
        lines.append(process_line(line))

    return lines

def process_line(the_line):
    global p, dir_path

    m = p.search(the_line)

    if m :
        inc_file = m.group('incfile')

        inc_path = os.path.join(dir_path, 'src', inc_file + '.tex')

        if os.path.isfile(inc_path):
            f = open(inc_path, 'r')

            try:
                return ''.join(process_file(f)) + '\n'
            finally:
                f.close()

    return the_line

for file in glob.glob("src/*.cls"):
    src_class = open(file, 'r')
    tar_class = open(file.replace('src/', 'dist/'), 'w')
    src_template = file.replace('.cls', '.tex')
    tar_template = src_template.replace('src/', 'dist/')

    try :
        tar_class.write(''.join(process_file(src_class)) + '\n')
        shutil.copyfile(src_template, tar_template)
    except Exception as e:
        print(e)
    finally:
        src_class.close()
        tar_class.close()
