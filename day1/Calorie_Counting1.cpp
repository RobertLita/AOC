// check day 1 here: https://adventofcode.com/2022/day/1

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

ifstream in("input.txt");

int main()
{
    long long mostCalories = 0, elveCalories = 0;
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
            if (elveCalories > mostCalories)
                mostCalories = elveCalories;
                
            elveCalories = 0;
        }
    }
    cout << mostCalories;

    // Your puzzle answer was 70698.
    
    return 0;
}
