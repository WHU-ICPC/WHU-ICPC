#-*-coding:utf-8-*-

import pandas as pd
import yaml
import random

HTML_head = \
'''
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style>
    .card {
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-size: 28px;
        width: 800px;
        /*background-color: rgb(230, 230, 230);*/
        border: 1px solid gray;
        border-radius: 5px;
        padding: 20px;
        margin: 20px;
    }

    .participantName {
        font-size: 30px;
        font-weight: bold;
		color:black;
    }

    code {
        font-family: "Calibri";
        color: dimgray;
        padding: 0 20px 0 0;
    }

    p {
        margin: 10px 10px 10px 0;
    }

    .break {page-break-after: always;}

    .siteLink {
        font-weight: bold;
        /*background-color: rgb(91, 192, 222);*/
        color: gray;
    }
</style>

</head><body>
'''

def HTML_body(name, account, password, seat, url) :
    return \
'''
<div class="card ">
    <div class="participantName">{}</div>

    <p>
        账号:
        <code>{}</code>
        密码:
        <code>{}</code>
    </p>

    <p>
        座位号：
        <code>{}</code>
        比赛网址:
        <code>{}</code>
    </p>
</div>
'''.format(name, account, password, seat, url)

HTML_tail = '''
</body></html>
'''

def password(n) :
    alphabet = 'ABDEFGHKMNPQRTWXYZ' + 'abdefghkmnpqrtwxyz' + '23456789'
    return ''.join(random.choices(alphabet, k=n))

csv_filename = 'teams.csv'

data = pd.read_csv(csv_filename).to_dict(orient='list')
n = len(data['name'])

if 'password' not in data :
    data['password'] = [password(8) for i in range(n)]
    df = pd.DataFrame(data)
    df.to_csv(csv_filename, encoding='utf-8', index=None)

with open('密码条.html', 'w', encoding='utf-8') as f:
    f.write(HTML_head)
    for i in range(n) :
        f.write(HTML_body(
            data['name'][i], data['username'][i], data['password'][i],
            "&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;" if pd.isnull(data['room'][i]) else data['room'][i],
            'https://judge.akakii.cn'
        ))
    f.write(HTML_tail)