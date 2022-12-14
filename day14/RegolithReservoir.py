# simple simulation solution, nothing fancy

rocks = set()
sands = set()
maxDepth = 0
ended = False


def parse():
    global rocks, maxDepth
    with open('day14/input.txt') as f:
        for line in f.readlines():
            line = line.split(' -> ')
            for i in range(len(line) - 1):
                rock1 = [int(line[i].split(',')[0]), int(line[i].split(',')[1])]
                rock2 = [int(line[i + 1].split(',')[0]), int(line[i + 1].split(',')[1])]
                if rock1[0] == rock2[0]:
                    if rock2[1] < rock1[1]:
                        rock1[1], rock2[1] = rock2[1], rock1[1]
                    for y in range(rock1[1], rock2[1] + 1):
                        maxDepth = max(maxDepth, y)
                        rocks.add((rock1[0], y))
                else:
                    if rock2[0] < rock1[0]:
                        rock1[0], rock2[0] = rock2[0], rock1[0]
                    maxDepth = max(maxDepth, rock1[1])
                    for x in range(rock1[0], rock2[0] + 1):
                        rocks.add((x, rock1[1]))


def nextPos(pos: tuple, part: int):
    under = (pos[0], pos[1] + 1)
    if under in sands or under in rocks or (part == 2 and under[1] == maxDepth + 2):
        underLeft = (pos[0] - 1, pos[1] + 1)
        if underLeft in sands or underLeft in rocks or (part == 2 and underLeft[1] == maxDepth + 2):
            underRight = (pos[0] + 1, pos[1] + 1)
            if underRight in sands or underRight in rocks or (part == 2 and underRight[1] == maxDepth + 2):
                return pos
            return underRight
        return underLeft
    return under


def dropSand(part: int):
    global sands, ended
    sandPos = (500, 0)
    sandRested = False
    while not sandRested:
        if part == 1 and sandPos[1] > maxDepth or part == 2 and (500, 0) in sands:
            ended = True
            sandRested = True
        nextSandPos = nextPos(sandPos, part)
        if sandPos == nextSandPos:
            sandRested = True
            sands.add(sandPos)
        sandPos = nextSandPos
        

def partOne():
    parse()
    while not ended:
        dropSand(1)
    return len(sands)
    

def partTwo():
    global ended
    ended = False
    parse()
    while not ended:
        dropSand(2)
    return len(sands)


if __name__ == "__main__":
    print(partOne())
    # Your puzzle answer was 885.

    print(partTwo())
    # Your puzzle answer was 28691.

