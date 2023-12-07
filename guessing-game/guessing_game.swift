print("Welcome to this guessing game. Enter a number from 1-10: ")

var correctGuess = false
var randomNum = Int.random(in: 1...10)
var guessedNum = 11

while correctGuess == false {
    
    guessedNum = Int(readLine()!)!
    
    if guessedNum == randomNum {
        correctGuess = true
        break
    }
    print("Incorrect guess, try again.")

}

print("Correct! The number is \(randomNum)")

