w = 0
h = 0
elves = set()
directions = {'N' : (-1, 0), 'S' : (1, 0), 'E' : (0, 1), 'W' : (0, -1), 'NE' : (-1, 1), 'NW' : (-1, -1), 'SW' : (1, -1), 'SE' : (1, 1)}
directionsToCheck = {'N' : ['N', 'NE', 'NW'], 'S' : ['S', 'SE', 'SW'], 'W' : ['W', 'NW', 'SW'], 'E' : ['E', 'NE', 'SE']}
roundDirections = ['N', 'S', 'W', 'E']

def parse() -> None:
    global elves, h, w, roundDirections

    roundDirections = ['N', 'S', 'W', 'E']
    elves.clear()
    with open ("day23/input.txt") as f:
        grid = f.read().splitlines()
    h = len(grid)
    w = len(grid[0])
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            if grid[i][j] == '#':
                elves.add((i, j))


def proposeMove(x: int, y: int) -> tuple:
    
    for direction, move in directions.items():
        newX = x + move[0]
        newY = y + move[1]
        if (newX, newY) in elves:
            break
    else:
        return -2


    for direction in roundDirections:
        for directionToCheck in directionsToCheck[direction]:
            newX = x + directions[directionToCheck][0]
            newY = y + directions[directionToCheck][1]
            if (newX, newY) in elves:
                break
        else:
            return (x + directions[direction][0], y + directions[direction][1])
    return -1


def moveElves() -> bool:
    global roundDirections
    
    elvesPositions = {}
    alone = 0

    for elf in elves:
        wantedPos = proposeMove(elf[0], elf[1])
        if wantedPos not in [-1, -2]:
            if wantedPos in elvesPositions:
                elvesPositions[wantedPos] = -1
            else:
                elvesPositions[wantedPos] = elf
        elif wantedPos == -2:
            alone += 1

    if len(elves) == alone: 
        return False

    for wantedPos, elf in elvesPositions.items():
        if elf != -1:
            elves.remove(elf)
            elves.add(wantedPos)
    roundDirections = roundDirections[1:] + [roundDirections[0]]

    return True


def insideRectangle() -> int:
    minX, minY = float('inf'), float('inf')
    maxX, maxY = float('-inf'), float('-inf')
    inside = 0
    for elf in elves:
        maxX = max(maxX, elf[0])
        maxY = max(maxY, elf[1])
        minX = min(minX, elf[0])
        minY = min(minY, elf[1])

    area = (maxX - minX + 1) * (maxY - minY + 1) 
    for elf in elves:
        if minX <= elf[0] <= maxX and minY <= elf[1] <= maxY:
            inside += 1
    return area - inside
    

def partOne() -> int:
    parse()
    for _ in range(10):
        moveElves()
    
    return insideRectangle()


def partTwo() -> int:
    round = 1
    parse()
    while(moveElves()):
        round += 1
    return round

if __name__ == "__main__":
    print(partOne())
    # Your puzzle answer was 4247.

    print(partTwo())
    # Your puzzle answer was 1049.
