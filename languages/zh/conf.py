#!/usr/bin/env python
# encoding: utf-8
import os
parent = os.path.dirname
BASEDIR = parent(parent(parent(os.path.abspath(__file__))))

execfile(os.path.join(BASEDIR, 'languages/baseconf.py'))

language = 'zh'
