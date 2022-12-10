x = 1
cycles = 1
s = 0

def parseInput() -> list:
    with open("day10/input.txt") as f:
        instructions = [instruction.split() for instruction in f.read().splitlines()]
    return instructions


def checkCycles():
    global s
    if cycles in [20, 60, 100, 140, 180, 220]:
        print(cycles * x)
        s += cycles * x


def manageInstruction(instr: list):
    global cycles, x
    if instr[0] == "addx":
        checkCycles()
        cycles += 1
        checkCycles()
        cycles += 1
        x += int(instr[1])
    else:
        checkCycles()
        cycles += 1
        

def solveOne():
    instructions = parseInput()
    for instr in instructions:
        manageInstruction(instr)
        if cycles > 220:
            break
    print(s)
    

if __name__ == "__main__":
    solveOne()
    # Your puzzle answer was 15260.