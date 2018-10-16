import re

a = 'PythonC#JavaPHPC#C#'

b = 'A6C56ED3CT8B'

# def  convert(value):
#     matched = value.group()
#     return '!!'+matched+'!!'
#     print (value)
def convert(value):
     matched = value.group()
     if int(matched)>=6:
         return '9'
     else:
         return '0'
r = re.sub('\d',convert,b)

print (r)
