import pygame

class ball():
    def __init__(self, pos_x, pos_y, width):
        self.x = pos_x
        self.y = pos_y
        self.width = width

    def draw(self, screen):
        pygame.draw.rect(
            screen, 
            "white",
            (self.x, self.y, self.width, self.width)
         )