package org.example;
import static com.raylib.Jaylib.*;
import com.raylib.Jaylib;

public class Main {
    public static void main(String[] args) {
        System.out.println("hello world");
        final int WIDTH = 600;
        final int HEIGHT = 400;
        final String TITLE = "Pong";

        InitWindow(WIDTH, HEIGHT, TITLE);
        SetTargetFPS(60);

        while(!WindowShouldClose()) {
            BeginDrawing();
            ClearBackground(GRAY);
            EndDrawing();
        }
        CloseWindow();

    }
}
