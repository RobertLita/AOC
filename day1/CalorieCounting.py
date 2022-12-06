print(sorted([sum(map(int, inventory.splitlines())) for inventory in open("day1/input.txt").read().split('\n\n')])[-1])
# Your puzzle answer was 70698.

print(sum(sorted([sum(map(int, inventory.splitlines())) for inventory in open("day1/input.txt").read().split('\n\n')])[-3:]))
# Your puzzle answer was 206643.