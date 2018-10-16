import json

# JSON  object array
json_str = '[{"name":"wangwei","age":17},{"name":"wawei","age":18}]'

student = json.loads(json_str)
print (type(student))
print (student)
# print(student['name'])
# print(student['age'])
