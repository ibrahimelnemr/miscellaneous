package org.example.Interfaces;

import com.raylib.Jaylib.*;

public interface IGameObject extends IBasicObject {
    
    public void move();
    public int getVelocity();
    public void setVelocity(int velocity);
}
