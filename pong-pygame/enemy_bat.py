import pygame
from bat import bat
from ball import ball

class enemy_bat(bat):
    def __init__(self, pos_x: int, pos_y: int, width: int, height: int,vel: int):
        super().__init__(pos_x, pos_y, width, height, vel)
    
    def move(self, ball: ball):
        if self.y > ball.y:
            self.vel *= 1
        elif self.y < ball.y:
            self.vel*=-1

        self.y += self.vel
