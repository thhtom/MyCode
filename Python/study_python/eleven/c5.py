

def f1():
    a =10
    def f2():
        a = 20
    return f2

f =f1()
print (f1)

print (f.__closure__)
