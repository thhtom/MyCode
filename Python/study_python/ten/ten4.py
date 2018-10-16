import re

s = '8BU89BG61SVV'

r = re.match('\d',s)

print (r.group())

r1 = re.search('\d',s)
print(r1.span())

r2 = re.findall('\d',s)

print (r2)
