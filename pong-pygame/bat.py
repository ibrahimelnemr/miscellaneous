import pygame

class bat:
    def __init__(self, pos_x: int, pos_y: int, width: int, height: int,vel: int):
        self._pos_x = pos_x
        self._pos_y = pos_y
        self.width = width
        self.height = height
        self.vel = vel
    
    def draw(self, screen):
        pygame.draw.rect(
            screen, 
            "white", 
            (self.pos_x, self.pos_y, self.width, self.height)
        )
    
    def move(self, direction):
        if direction == "UP":
            self.pos_y -= self.vel
        elif direction == "DOWN":
            self.pos_y += self.vel
    
     #pos x getter
    @property
    def pos_x(self):
        return self._pos_x

    #pos x setter
    @pos_x.setter
    def pos_x(self, new_pos_x: int):
        self._pos_x = new_pos_x
        
    #pos y getter
    @property
    def pos_y(self):
        return self._pos_y
    
    #pos y setter
    @pos_y.setter
    def pos_y(self, new_pos_y: int):
        self._pos_y = new_pos_y
 