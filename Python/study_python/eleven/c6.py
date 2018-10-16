
#非闭包
origin = 0

def go(step):
    global origin
    new_postion =origin+step
    origin = new_postion
    return origin

print (go(2))
print (go(3))
print (go(6))
