package org.example;
import static com.raylib.Jaylib.WHITE;

import java.util.Vector;

import org.example.Interfaces.IGameObject;

import com.raylib.Jaylib.*;
import com.raylib.Jaylib;

public class GameObject implements IGameObject {
    private Vector2 position;
    private Vector2 size;
    private int velocity;

    public GameObject(Vector2 position, Vector2 size, int velocity) {
        this.position = position;
        this.size = size;
        this.velocity = velocity;
    }

    public void draw() {
        Jaylib.DrawRectangle((int)position.x(), (int)position.y(), (int)size.x(), (int)size.y(), WHITE);
    }

    public void move() {
        this.position.x(this.position.x() + this.velocity);
        this.position.y(this.position.y() + this.velocity);
    }

    public void setVelocity(int velocity) {
        this.velocity = velocity;
    }

    public int getVelocity() {
        return this.velocity;
    }

    public void setPosition(Vector2 position) {
        this.position = position;
    }

    public Vector2 getPosition() {
        return this.position;
    }
}
