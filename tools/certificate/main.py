# -*- coding: UTF-8 -*-
from string import Template
import os
import shutil
import pandas as pd

def certificate(tex, info) :
    for (k,v) in info.items() :
        tex = tex.replace(k, v)
    return tex

def generate(filename, tex, info) :
    def _mkdir(path) :
        if not os.path.exists(path) :
            os.makedirs(path)
    
    _mkdir('tex/')
    _mkdir('output/')
    shutil.copyfile('ICPClogo.png', 'tex/ICPClogo.png')

    with open('tex/main.tex', 'w', encoding='utf-8') as f:
        f.write(certificate(tex, info))
    
    os.chdir('tex/')
    os.system('xelatex main.tex')
    os.chdir('../')
    shutil.copyfile('tex/main.pdf', 'output/{}'.format(filename))
    shutil.rmtree('tex/')


data = pd.read_csv('input.csv').to_dict(orient='list')
n = len(data['name'])

with open('template.tex', 'r', encoding='utf-8') as f :
    tex = f.read()

for i in range(n) :
    generate(
        filename = '2022新生赛_{}_{}.pdf'.format(data['award'][i], data['name'][i]),
        tex = tex,
        info = {
            "CONTEST"      : '2022武汉大学新生程序设计竞赛',
            "NAME"         : data['name'][i],
            "AWARD"        : data['award'][i],
            "SCHOOL"       : '武汉大学计算机学院',
            "ORGANIZATION" : '武汉大学ACM/ICPC协会',
            "DATE"         : '2022年10月15日',
        }
    )