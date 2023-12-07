from re import findall, search
from dataclasses import dataclass

color_pattern = r'\d{1,2} green|\d{1,2} red|\d{1,2} blue'
game_id_pattern = r'Game (\d+):'

class Set: 
    red: int = 0
    green: int = 0
    blue: int = 0

    def __init__(self, colors: list):
        for color in colors:
            number, color_name = color.split()
            if 'red' in color_name:
                self.red = int(number)
            elif 'green' in color_name:
                self.green = int(number)
            else:
                self.blue = int(number)
    
    def __repr__(self) -> str:
        return f"RED: {self.red} GREEN: {self.green} BLUE: {self.blue}"


class Game:
    id: int =  0
    sets: list[Set]

    def __init__(self, id) -> None:
       self.id = id

    def __repr__(self) -> str:
        return f"GAME: {self.id} {str(self.sets)}"
    
    def id_for_good_sets(self) -> bool:
        is_good = True
        for set in self.sets:
            is_good = is_good and (set.blue <= Playing.BLUE) and (set.red <= Playing.RED) and (set.green <= Playing.GREEN)
        
        return self.id if is_good else 0
    
    def minimum_colors_cubes(self) -> tuple:
        max_red = max(set.red for set in self.sets)
        max_blue = max(set.blue for set in self.sets)
        max_green = max(set.green for set in self.sets)
        
        return max_red * max_blue * max_green


class Playing:
    
    RED: int = 0
    GREEN: int = 0
    BLUE: int = 0
    FILE: str = ''
    games: list[Game] = []

    def __init__(self, red, green, blue, file):
        Playing.RED = red
        Playing.GREEN = green
        Playing.BLUE = blue
        self.FILE = file
        self.parse_input()

    def read_file(self) -> list:
        with open(self.FILE) as f:
            return f.readlines()
        
    def parse_input(self):
        input = self.read_file()
        self.games = list(map(lambda x: Game(int(search(game_id_pattern, x).group(1))), input))
        sets = map(lambda x: list(map(lambda y: Set(findall(color_pattern, y)), x.split(':')[1].split(';'))) , input)
        for index, set in enumerate(sets):
            self.games[index].sets = set

    def __repr__(self) -> str:
        return f"{str(self.games)}"
    
    def solve_part1(self) -> int:
        return sum(map(Game.id_for_good_sets, self.games))

    def solve_part2(self) -> int:
        return sum(map(Game.minimum_colors_cubes, self.games))


if __name__ == "__main__":
    g = Playing(12, 13, 14, "input.txt")

    print(g.solve_part1())
    # Your puzzle answer was 2486.

    print(g.solve_part2())
    # Your puzzle answer was 87984.
