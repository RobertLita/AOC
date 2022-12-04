print(sum(map(lambda y: 1 if y[0] <= y[2] and y[1] >= y[3] or y[0] >= y[2] and y[1] <= y[3] else 0, map(lambda x: list(map(int, x[0].split('-'))) + list(map(int, x[1].split('-'))), [pairs.split(',') for pairs in open("day4/input.txt").readlines()]))))
# Your puzzle answer was 513.

print(sum(map(lambda y: 1 if y[0] <= y[3] and y[2] <= y[1] else 0, map(lambda x: list(map(int, x[0].split('-'))) + list(map(int, x[1].split('-'))), [pairs.split(',') for pairs in open("day4/input.txt").readlines()]))))
# Your puzzle answer was 878.