import re



# print(a.index('Python')>-1)
# print('Python' in a)

r = re.findall('PHP',a)

if len(r) > 0:
    print('it is  include Python')
else:
    print ('No')

print (r)
