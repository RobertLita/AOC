// check day 1 here: https://adventofcode.com/2022/day/1

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

ifstream in("input.txt");

int main()
{
    long long mostCalories[3] = {0}, elveCalories = 0;
    int caloriesCarried = 0;

    string reading;

    while(!in.eof())
    {
        getline(in, reading);

        if (!reading.empty())
        {
            caloriesCarried = stoi(reading);
            elveCalories += caloriesCarried;
        }
        else
        {
            if (elveCalories >= mostCalories[0])
            {
                mostCalories[2] = mostCalories[1];
                mostCalories[1] = mostCalories[0];
                mostCalories[0] = elveCalories;
            }
            else if (elveCalories > mostCalories[1])
            {
                mostCalories[2] = mostCalories[1];
                mostCalories[1] = elveCalories;
            }
            else if (elveCalories > mostCalories[2])
            {
                mostCalories[2] = elveCalories;
            }

            elveCalories = 0;
        }
    }
    cout << mostCalories[0] + mostCalories[1] + mostCalories[2];

    // Your puzzle answer was 206643.

    return 0;
}
