def parse() -> list:
    with open ("day13/input.txt") as f:
        lists = [(eval(pair.splitlines()[0]), eval(pair.splitlines()[1])) for pair in f.read().split('\n\n')]
    return lists


def compare(lh: list, rh: list) -> int:
    if lh == []:
        return 0 if rh == [] else -1
    if rh == []:
        return 1
    if isinstance (lh, list):
        if isinstance (rh, list):
            x = compare(lh[0], rh[0])
            return x if x else compare(lh[1:], rh[1:])
        return compare(lh, [rh])
    if isinstance (rh, list):
        return compare([lh], rh)
    return -1 if lh < rh else 1 if rh < lh else 0
        

def partOne() -> int:
    pairLists = parse()
    return sum([i + 1 if compare(pair[0], pair[1]) <= 0 else 0 for i, pair in enumerate(pairLists)])


def partTwo() -> int:
    lists = []
    pairLists = parse()
    for pair in pairLists:
        lists.append(pair[0])
        lists.append(pair[1])

    lists.append([[2]])
    lists.append([[6]])

    # too lazy for a faster sorting
    for i in range(len(lists) - 1):
        for j in range(i + 1, len(lists)):
            if compare(lists[i], lists[j]) > 0:
                lists[i], lists[j] = lists[j], lists[i]
    return (lists.index([[2]]) + 1) * (lists.index([[6]]) + 1)


if __name__ == "__main__":
    print(partOne())    
    # Your puzzle answer was 5366.

    print(partTwo())
    # Your puzzle answer was 23391.