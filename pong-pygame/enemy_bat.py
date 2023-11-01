import pygame
from bat import bat
from ball import ball

class enemy_bat():
    def __init__(self, pos_x, pos_y, width, height,vel):
        self.x = pos_x
        self.y = pos_y
        self.width = width
        self.height = height
        self.vel = vel
    
    def move(self, ball: ball):
        if self.y > ball.y:
            self.vel *= 1
        elif self.y < ball.y:
            self.vel*=-1

        self.y += self.vel

    def draw(self, screen):
        pygame.draw.rect(
            screen, 
            "white", 
            (self.x, self.y, self.width, self.height)
            )
