#!/usr/bin/env python
from __future__ import print_function
import io

with io.open('d.txt','r',encoding='utf-8',errors='ignore') as infile, \
     io.open('d_parsed.txt','w',encoding='ascii',errors='ignore') as outfile:
    for line in infile:
        print(*line.split(), file=outfile)