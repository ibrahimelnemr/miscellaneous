#include <iostream>
#include <random>
#include <ctime>
using namespace std;

int main()
{
    bool correct_guess = false;

    cout << "Welcome to this guessing game. Enter a number from 1-10: ";
    int number;
    srand((unsigned)time(0));
    int randnum = rand() % 10 + 1;

    while (correct_guess == false)
    {
        cin >> number;

        if (number == randnum)
        {
            printf("You have guessed correctly. The number is %d\n", randnum);
            correct_guess = true;
        }

        else
        {
            printf("Incorrect guess. Try again.\n");
        }
            
    }
}