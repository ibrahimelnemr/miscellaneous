import random
print("Welcome to this guessing game. Enter a number from 1-10: ")
correct_guess = False

while(correct_guess == False):
    try:
        num = int(input())
    except:
        print("You entered an invalid value.")
        break
    randnum = random.randrange(10)

    if (num == randnum):
        print(f"You have guessed correctly. The number is {randnum}\n")
        correct_guess=True
    else:
        print(f"You have guessed incorrectly. Try again.")