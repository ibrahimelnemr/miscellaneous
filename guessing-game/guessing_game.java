import java.util.Random;
import java.util.Scanner;

public class guessing_game {
    public static void main(String[] args) {

        boolean correctGuess = false;

        System.out.println("Enter a number from 1-10: ");

        Scanner sc = new Scanner(System.in);

        Random rnd = new Random();

        int num = rnd.nextInt(10) + 1;

        while (correctGuess == false) {
            int guess = sc.nextInt();
        
            if (guess == num) {
                System.out.println("You guessed correct! The number is " + num);
                break;
            }

            else {
                System.out.println("Incorrect guess! Try again.");
            }
        }

        sc.close();
    }

}