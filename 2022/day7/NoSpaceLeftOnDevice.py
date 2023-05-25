from collections import defaultdict

data = open("day7/input.txt").read().strip()
sizes = defaultdict(int)
path = []
for line in data.split("\n"):
    if line.startswith("$ cd"):
        d = line.split()[2]
        if d == "/":
            path.append("/")
        elif d == "..":
            last = path.pop()
        else:
            path.append(f"{path[-1]}{'/' if path[-1] != '/' else ''}{d}")
    if line[0].isnumeric():
        for p in path:
            sizes[p] += int(line.split()[0])

print(sum(s for s in sizes.values() if s <= 100_000))
# Your puzzle answer was 1583951.

print(min(s for s in sizes.values() if s >= 30_000_000 - (70_000_000 - sizes['/'])))
# Your puzzle answer was 214171.