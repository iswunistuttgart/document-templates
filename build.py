#!/usr/bin/env python3
# coding=utf-8

import glob
import os
import re
import shutil

path_base = os.path.dirname(os.path.realpath(__file__))
dir_src = os.path.join(path_base, 'src')
dir_dist = os.path.join(path_base, 'dist')
files = ['doctorate', 'student']

p = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')

def process_file(the_file):
    lines = []

    for line in the_file:
        lines.append(process_line(line))

    return lines

def process_line(the_line):
    global p, path_base

    m = p.search(the_line)

    if m :
        inc_file = m.group('incfile')

        path_inc_file = os.path.join(path_base, 'src', inc_file + '.tex')

        if os.path.isfile(path_inc_file):
            f = open(path_inc_file, 'r')

            try:
                return ''.join(process_file(f)) + '\n'
            finally:
                f.close()

    return the_line

for file in files:
    src_class = open(os.path.join(dir_src, file + '.cls'), 'r')
    tar_class = open(os.path.join(dir_dist, file + '.cls'), 'w')
    src_template = os.path.join(dir_src, file + '.tex')
    tar_template = os.path.join(dir_dist, file + '.tex')

    try :
        tar_class.write(''.join(process_file(src_class)) + '\n')
        shutil.copyfile(src_template, tar_template)
    except Exception as e:
        print(e)
    finally:
        src_class.close()
        tar_class.close()
