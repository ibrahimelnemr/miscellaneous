import pygame

class ball():
    def __init__(self, pos_x: int, pos_y: int, width: int):
        self.x = pos_x
        self.y = pos_y
        self.width = width

    def draw(self, screen: pygame.Surface):
        pygame.draw.rect(
            screen, 
            "white",
            (self.x, self.y, self.width, self.width)
         )