import json

student = [{'name':'xiaohong','age':15,'falg':True},
            {'name':'xiaohong','age':15}]

json_str = json.dumps(student)
print(type(json_str))
print(json_str)
