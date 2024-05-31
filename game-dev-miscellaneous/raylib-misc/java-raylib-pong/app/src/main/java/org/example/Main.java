package org.example;
import static com.raylib.Jaylib.*;
import com.raylib.Jaylib;
import com.raylib.Jaylib.Vector2;

public class Main {
    public static void main(String[] args) {
        System.out.println("hello world");
        final int WIDTH = 600;
        final int HEIGHT = 400;
        final String TITLE = "Pong";

        InitWindow(WIDTH, HEIGHT, TITLE);
        SetTargetFPS(60);

        final int batVel = 5;
        final int ballVel = 7;

        final Vector2 playerBatSize = new Vector2(5, 30);
        final Vector2 enemyBatSize = new Vector2(5, 30);
        final Vector2 ballSize = new Vector2(5, 5);

        final Vector2 playerBatStartPosition = new Vector2(10, 
        HEIGHT / 2);
        final Vector2 enemyBatStartPosition = new Vector2(WIDTH - 10, HEIGHT / 2);
        final Vector2 ballStartPosition = new Vector2(WIDTH / 2, HEIGHT / 2);

        PlayerBat playerBat = new PlayerBat(playerBatStartPosition, playerBatSize, batVel);
        EnemyBat enemyBat = new EnemyBat(enemyBatStartPosition, enemyBatSize, batVel);
        Ball ball = new Ball(ballStartPosition, ballSize, ballVel);
        // Score score = new Score();


        while(!WindowShouldClose()) {
            BeginDrawing();
            ClearBackground(GRAY);

            // draw objects
            Draw draw = new Draw(playerBat, enemyBat, ball);

            draw.drawAllObjects();
            
            EndDrawing();
        }
        CloseWindow();

    }
}
