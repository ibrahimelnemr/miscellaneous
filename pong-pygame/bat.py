import pygame

class bat():
    vel_x = 0
    vel_y = 0
    def __init__(self, pos_x, pos_y, width, height, vel):
        self.x = pos_x
        self.y = pos_y
        self.width = width
        self.height = height
        self.vel = vel
    
    def draw(self, screen: pygame.Surface):
        pygame.draw.rect(
            screen, 
            "white", 
            (self.x, self.y, self.width, self.height)
            )