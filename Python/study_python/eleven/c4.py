
def cure_pre():
    a = 25
    def cure(x):
        return  a*x*x
        pass
    return cure

f = cure_pre()
print(f(2))
