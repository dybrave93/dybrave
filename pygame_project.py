# -*- coding: utf-8 -*-
"""
Spyder Editor

Dongyu Zhu
dybrave@bu.edu- term project- A interesting penalty shootout game
"""

from random import choice

score = [0, 0]
rest = [5, 5]
direction = ['left', 'center', 'right']

def kick():
    print ('==== You Kick! ====')
    print ('Choose one side to shoot:')
    print ('left, center, right')
    you = input()
    print ('You kicked ' + you)
    com = choice(direction)
    print ('Computer saved ' + com)
    if you != com:
       print ('Goal!')
       score[0] += 1
    else:
        print ('Oops...')
        print ('Score: %d(you) - %d(com)\n' % (score[0], score[1]))
    if rest[0] > 0:
        rest[0] -= 1
    if score[0] < score[1] and score[0] + rest[0] < score[1]:
        return True
    if score[1] < score[0] and score[1] + rest[1] < score[0]:
        return True
    print ('==== You Save! ====')
    print ('Choose one side to save:')
    print ('left, center, right')
    you = input()
    print ('You saved ' + you)
    com = choice(direction)
    print ('Computer kicked ' + com)
    if you == com:
        print ('Saved!')
    else:
       print ('Oops...')
       score[1] += 1
       print ('Score: %d(you) - %d(com)\n' % (score[0], score[1]))
    if rest[1] > 0:
        rest[1] -= 1
    if score[0] < score[1] and score[0] + rest[0] < score[1]:
        return True
    if score[1] < score[0] and score[1] + rest[1] < score[0]:
        return True
    return False


i = 0
end = False
while(i < 5 and not end):
    print ('==== Round %d ====' % (i+1))
    end = kick()
    i += 1

while(score[0] == score[1]):
   print ('==== Round %d ====' % (i+1))
   kick()
   i += 1
if score[0] > score[1]:
   print ('You Win!')
else:
   print ('You Lose.')
    
   