#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
  File: __file_name__.py
  Desc: __file_description__
  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
"""

import sys


def main():
  try:
    arg = sys.argv[1]
  except IndexError:
    sys.stderr.write('Usage: %s <arg>\n'%sys.argv[0])
    sys.exit(1)

if __name__ == '__main__':
  main()

