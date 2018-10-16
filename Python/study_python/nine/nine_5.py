# import nine_6
from nine6 import People

class Student(People):
    sum = 0
    def __init__ (self, name,age):
        self.name = name
        self.age = age
        self.__score = 0
        self.__class__.sum += 1
    def do_homework(self):
        print('enflish homework')
student1 = Student('wangxiao',18)

print(student1.sum)
print(student1.name)
print(student1.age)
