/*
Given a string containing a set of words separated by whitespace, we would like to transform it to a string in which the words appear in the reverse order. For example, "Alice likes Bob" transforms to "Bob likes Alice". We do not need to keep the original string.
*/

/**
 * ReverseSentenceWords
 */
import java.util.ArrayList;

public class ReverseSentenceWords {

    public static String reverseSentenceWords(String sentence) {

        String[] initialSentence = sentence.split(" ");

        StringBuilder finalSentence = new StringBuilder();

        System.out.printf("array length: %d\n", initialSentence.length);
        
        for (int i = 0; i < initialSentence.length; i++) {
            finalSentence.append(initialSentence[initialSentence.length - i - 1]);
            if (i < initialSentence.length - 1) {
                finalSentence.append(" ");
            }
        }

        return finalSentence.toString();
    
    }

    public static String reverseString(String str) {
        StringBuilder builder = new StringBuilder(str);
        return builder.reverse().toString();
    }

    public static void main(String[] args) {
        String sentence = "The quick brown fox";
        System.out.printf("Initial: %s \n", sentence);
        String reversed = reverseSentenceWords(sentence);
        System.out.printf("Reversed: %s \n", reversed);
    }

}