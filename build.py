#!/usr/bin/env python3
# coding=utf-8

import os
import re
import shutil
import datetime
import time

path_base = os.path.dirname(os.path.realpath(__file__))
dir_src = os.path.join(path_base, 'src')
dir_dist = os.path.join(path_base, 'dist')
files = ['iswstud', 'iswartcl', 'iswdctrt']


p_incfile = re.compile('\\\\(input|include)\\{(?P<incfile>.*)\\}')
p_time = re.compile('\\\\filedate\\{(?P<filedate>.*)\\}')


def process_file(the_file):
    lines = []

    for line in the_file:
        lines.append(process_line(line))

    return lines

def process_line(the_line):
    global p, path_base

    m_incfile = p_incfile.search(the_line)
    m_time = p_time.search(the_line)

    if m_incfile :
        inc_file = m_incfile.group('incfile')

        path_inc_file = os.path.join(path_base, 'src', inc_file + '.tex')

        if os.path.isfile(path_inc_file):
            f = open(path_inc_file, 'r')

            try:
                return ''.join(process_file(f))
            finally:
                f.close()
    elif m_time:
        return the_line.replace(m_time.group('filedate'), datetime.datetime.utcnow().strftime('%Y/%m/%d'))

    return the_line

for file in files:
    src_class = open(os.path.join(dir_src, file + '.cls'), 'r')
    tar_class = open(os.path.join(dir_dist, file + '.cls'), 'w')
    src_template = os.path.join(dir_src, file + '.tex')
    tar_template = os.path.join(dir_dist, file + '.tex')

    try :
        tar_class.write(''.join(process_file(src_class)))
        shutil.copyfile(src_template, tar_template)
    except Exception as e:
        print(e)
    finally:
        src_class.close()
        tar_class.close()
