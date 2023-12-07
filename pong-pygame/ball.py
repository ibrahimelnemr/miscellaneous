import pygame

class ball():
    def __init__(self, pos_x: int, pos_y: int, width: int, vel: int):
        self._pos_x = pos_x
        self._pos_y = pos_y
        self._width = width
        self.vel = vel
        self._dir_x = 1
        self._dir_y = 1

    def draw(self, screen):
        pygame.draw.rect(
            screen, 
            "white",
            (self._pos_x, self._pos_y, self.width, self.width)
         )

    def move(self):
        self.pos_x += self.dir_x * self.vel
        self.pos_y += self.dir_y * self.vel

    #pos x getter
    @property
    def pos_x(self):
        return self._pos_x
    
    @property
    def width(self):
        return self._width

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
    
    #dir x getter
    @property
    def dir_x(self):
        return self._dir_x

    #dir_x setter
    @dir_x.setter
    def dir_x(self, new_dir_x: int):
        self._dir_x = new_dir_x
        
    #dir y getter
    @property
    def dir_y(self):
        return self._dir_y
    
    #dir y setter
    @dir_y.setter
    def dir_y(self, new_dir_y: int):
        self._dir_y = new_dir_y
    



