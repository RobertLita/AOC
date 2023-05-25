timesInspected = []
modulo = 1

def parse() -> list:
    global modulo
    monkeys = []
    with open ("day11/input.txt") as f:
        for monkey in f.read().split('\n\n'):
            monkey = monkey.splitlines()
            items = [int(x.strip()) for x in monkey[1].split(':')[1].split(',')]
            op = monkey[2].split('=')[1].strip()
            testCondition = int(monkey[3].split()[-1])
            modulo *= testCondition
            goTo = (int(monkey[4].split()[-1]), int(monkey[5].split()[-1]))
            monkeys.append([items, op, testCondition, goTo])
    return monkeys, modulo
    

def handleOperation(op: str, value: int) -> int:
    _, sign, y = op.split()
    if y == "old":
        y = value
    match sign:
        case '+':
            return value + int(y)
        case '*':
            return value * int(y)


def handleItem(value: int, op: str, d: int, cases: tuple, part: int) -> tuple:
    worryLevel = handleOperation(op, value)
    if part == 1:
        worryLevel //= 3
    else:
        worryLevel %= modulo
    if worryLevel % d == 0:
        return (worryLevel, cases[0])
    return (worryLevel, cases[1])


def round(monkeys: list, part: int):
    global timesInspected
    for i in range(len(monkeys)):
        for item in monkeys[i][0]:
            (worryLevel,  nextMonkey) = handleItem(item, monkeys[i][1], monkeys[i][2], (monkeys[i][3][0], monkeys[i][3][1]), part)
            monkeys[i][0] = monkeys[i][0][1:]
            monkeys[nextMonkey][0].append(worryLevel)
            timesInspected[i] += 1

def partOne() -> int:
    global timesInspected
    monkeys, _ = parse()
    timesInspected = [0 for _ in range(len(monkeys))]
    for _ in range(20):
        round(monkeys, 1)
    timesInspected.sort(reverse=True)
    return timesInspected[0] * timesInspected[1]


def partTwo() -> int:
    global timesInspected
    monkeys, modulo = parse()
    timesInspected = [0 for _ in range(len(monkeys))]
    for _ in range(10000):
        round(monkeys, 2)
    timesInspected.sort(reverse=True)
    return timesInspected[0] * timesInspected[1]

if __name__ == "__main__":
    print(partOne())
    # Your puzzle answer was 182293.

    print(partTwo())
    # Your puzzle answer was 54832778815.

