import random

s = '23456789' + 'ABDEFGHMNPQRT' + 'abdefghmnpqrt'

for i in range(240) :
    for j in range(8) :
        print(random.choice(s), end='')
    print()
