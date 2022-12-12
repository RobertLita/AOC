from copy import deepcopy

grid = []
start = (0, 0)
end = (0, 0)

def parse():
    global grid, start, end
    with open ('day12/input.txt') as f:
        grid = [list(row) for row in f.read().splitlines()]
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            if grid[i][j] == 'S':
                start = (i, j)
                grid[i][j] = 'a'
            elif grid[i][j] == 'E':
                end = (i, j)
                grid[i][j] = 'z'
    

def inside(point: tuple) -> bool:
    return point[0] >= 0 and point[1] >= 0 and point[0] < len(grid) and point[1] < len(grid[0])


def validDestination(prevPointVal: str, nextPointVal: str) -> bool:
    return ord(prevPointVal) + 1 >= ord(nextPointVal)


def lee(startingPoint: tuple) -> int:
    global grid
    auxgrid = deepcopy(grid)
    dirx = [0, 1, 0, -1]
    diry = [-1, 0, 1, 0]
    q = [(startingPoint[0], startingPoint[1], 0)]
    p = 0
    while p < len(q) and (q[-1][0], q[-1][1]) != end:
        currentPoint = q[p]
        for i in range(4):
            nextPoint = (currentPoint[0] + dirx[i], currentPoint[1] + diry[i], currentPoint[2] + 1)
            if inside(nextPoint) and auxgrid[nextPoint[0]][nextPoint[1]] != '#'and validDestination(auxgrid[currentPoint[0]][currentPoint[1]], grid[nextPoint[0]][nextPoint[1]]):
                q.append(nextPoint)
        auxgrid[currentPoint[0]][currentPoint[1]] = '#'
        p += 1

    if q[-1][0] == end[0] and q[-1][1] == end[1]:
        return q[-1][2]
    return float('inf')


def partOne() -> int:
    parse()
    minSteps = lee(start)
    return minSteps

def partTwo() -> int:
    minSteps = float('inf')
    possibleStartingPoints = [(i, j) for i in range(len(grid)) for j in range(len(grid[i])) if grid[i][j] == 'a'] + [(start[0], start[1])] 
    for p in possibleStartingPoints:
        minSteps = min(minSteps, lee(p))
    return minSteps

if __name__ == "__main__":
    print(partOne())
    # Your puzzle answer was 517.

    print(partTwo())
    # Your puzzle answer was 512.