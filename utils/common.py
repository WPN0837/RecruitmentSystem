import random


def code():
    char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    s = ''.join(random.choices(char, k=8))
    return s
