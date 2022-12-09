
def sign(x: int):
    return (x > 0) - (x < 0) 

def move_tail_element(p1: list, p2: list):
    xdelta = p1[0] - p2[0]
    ydelta = p1[1] - p2[1]
    if abs(xdelta) > 1 or abs(ydelta) > 1:
        p2[0] += sign(xdelta)
        p2[1] += sign(ydelta)

def move_head(h: list, dir: str):
    h[0] += 1 if dir == 'R' else -1 if dir == 'L' else 0
    h[1] += 1 if dir == 'U' else -1 if dir == 'D' else 0

def move(rope: list, direction: str):
    move_head(rope[0], direction)

    for i in range(1, len(rope)):
        move_tail_element(rope[i - 1], rope[i])

    return tuple(rope[-1])

def simulate(rope: list):
    return { move(rope, direction) for direction, num in (line.split() for line in open("day9/input.txt")) for _ in range(int(num)) }


print(len(simulate([[0, 0] for n in range(2)])))
# Your puzzle answer was 6256.

print(len(simulate([[0, 0] for n in range(10)])))
# Your puzzle answer was 2665.
