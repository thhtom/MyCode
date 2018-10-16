from enum import Enum

class VIP(Enum):
    YELLOW = 1
    GREEN = 2
    BLACK = 3
    RED = 4

class Common():
    YELLOW = 1

for v in VIP.__members__:
    print(v)

print (VIP.YELLOW)
