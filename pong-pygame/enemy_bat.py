import pygame
import ball
from bat import bat

class enemy_bat(bat):
    def __init__(self, pos_x: int, pos_y: int, width: int, height: int,vel: int):
        super().__init__(pos_x, pos_y, width, height, vel)
        self.dir_y = 1
    
    def move(self):
        self.pos_y += self.dir_y * self.vel

