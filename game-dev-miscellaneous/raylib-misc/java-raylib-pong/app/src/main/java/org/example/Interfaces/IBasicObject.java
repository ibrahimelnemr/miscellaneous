package org.example.Interfaces;

import com.raylib.Jaylib.Vector2;

public interface IBasicObject {
    public void draw();
    public Vector2 getPosition();
    public void setPosition(Vector2 position );
}
