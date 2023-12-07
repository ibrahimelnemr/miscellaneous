import pygame
from bat import bat

class player_bat(bat):
    def __init__(self, pos_x: int, pos_y: int, width: int, height: int,vel: int):
        super().__init__(pos_x, pos_y, width, height, vel)