#!/usr/bin/env python

import sys
import math

numbers = [float(line) for line in sys.stdin]

count = len(numbers)
min = min(numbers)
max = max(numbers)
total = sum(numbers)
mean = total / count if count > 0 else 0
dev_sum = sum([(num - mean) ** 2 for num in numbers])
variance = dev_sum / count if count > 0 else 0
std_dev = math.sqrt(variance) if count > 0 else 0

print(f"count:     {count}")
print(f"min:       {min}")
print(f"max:       {max}")
print(f"sum:       {total}")
print(f"mean:      {mean}")
print(f"variance:  {variance}")
print(f"std dev:   {std_dev}")
