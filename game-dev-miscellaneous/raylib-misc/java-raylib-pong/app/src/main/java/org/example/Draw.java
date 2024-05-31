package org.example;

import org.example.Ball;
import org.example.PlayerBat;
import org.example.EnemyBat;
import org.example.Score;

public class Draw {
    Ball ball;
    PlayerBat playerBat;
    EnemyBat enemyBat;
    Score score;

    public Draw(PlayerBat playerBat, EnemyBat enemyBat, Ball ball/*Score score*/) {
        this.ball = ball;
        this.playerBat = playerBat;
        this.enemyBat = enemyBat;

    }

    public void drawAllObjects() {
        this.ball.draw();
        this.playerBat.draw();
        this.enemyBat.draw();
    }
}
