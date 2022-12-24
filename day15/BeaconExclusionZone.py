# the code is ugly and slow but it works :/

SB = {}
borderPoints = set()
notBeacons = set()
targetRow = 2000000

def parse() -> None:
    global SB
    with open ("day15/input.txt") as f:
        data = f.readlines() 
    
    for sensorData in data:
        parts = sensorData.split()
        sx, sy = int(parts[2][2:-1]), int(parts[3][2:-1])
        bx, by = int(parts[8][2:-1]), int(parts[9][2:])
        SB[(sx, sy)] = (bx, by)


def partOne() -> int:
    global notBeacons
    parse()
    for sensor, beacon in SB.items():
        dist = abs(sensor[0] - beacon[0]) + abs(sensor[1] - beacon[1])
        downBound = sensor[1] + dist
        upBound = sensor[1] - dist
        if downBound >= targetRow >= sensor[1]:
            notBeacons.add((sensor[0], targetRow))
            for i in range(1, downBound - targetRow + 1):
                notBeacons.add((sensor[0] - i, targetRow))
                notBeacons.add((sensor[0] + i, targetRow))
            try:
                notBeacons.remove((beacon[0], beacon[1]))
            except KeyError:
                pass
        elif upBound <= targetRow < sensor[1]:
            notBeacons.add((sensor[0], targetRow))
            for i in range(1, targetRow - upBound + 1):
                notBeacons.add((sensor[0] - i, targetRow))
                notBeacons.add((sensor[0] + i, targetRow))
            try:
                notBeacons.remove((beacon[0], beacon[1]))
            except KeyError:
                pass

    return len(notBeacons)


def partTwo() -> int:
    global borderPoints
    parse()
    for sensor, beacon in SB.items():
        dist = abs(sensor[0] - beacon[0]) + abs(sensor[1] - beacon[1])
        x = (sensor[0], sensor[1] + dist + 1)
        y = (sensor[0], sensor[1] + dist + 1)
        p = (sensor[0], sensor[1] - dist - 1)
        q = (sensor[0], sensor[1] - dist - 1)
        borderPoints.add(x)
        borderPoints.add(p)
        x = (x[0] - 1, x[1] - 1)
        y = (y[0] + 1, y[1] - 1)
        p = (p[0] - 1, p[1] + 1)
        q = (q[0] + 1, q[1] + 1)
        while x != p:
            borderPoints.add(x)
            borderPoints.add(y)
            borderPoints.add(p)
            borderPoints.add(q)
            x = (x[0] - 1, x[1] - 1)
            y = (y[0] + 1, y[1] - 1)
            p = (p[0] - 1, p[1] + 1)
            q = (q[0] + 1, q[1] + 1)
        borderPoints.add(x)
        borderPoints.add(y)

    for point in borderPoints:
        if 0 <= point[0] <= 4000000 and 0 <= point[1] <= 4000000:
            bad = False
            for sensor, beacon in SB.items():
                distToPoint = abs(sensor[0] - point[0]) + abs(sensor[1] - point[1])
                distToBeacon = abs(sensor[0] - beacon[0]) + abs(sensor[1] - beacon[1])
                if distToPoint <= distToBeacon:
                    bad = True
                    break
            if bad == False:
                return point[0] * 4000000 + point[1]

if __name__ == "__main__":
    print(partOne())
    # Your puzzle answer was 4424278.

    print(partTwo())
    # Your puzzle answer was 10382630753392.