import pygame
from bat import bat

class player_bat(bat):
    def __init__(self, pos_x, pos_y, width, height,vel):
        self.x = pos_x
        self.y = pos_y
        self.width = width
        self.height = height
        self.vel = vel

    def move(self):
        self.y += self.vel
    
    def draw(self, screen):
        pygame.draw.rect(
            screen, 
            "white", 
            (self.x, self.y, self.width, self.height)
            )
