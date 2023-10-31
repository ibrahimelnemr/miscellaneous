import pygame
import time
import random
from bat import bat
from enemy_bat import enemy_bat
from player_bat import player_bat
from ball import ball


pygame.font.init()

WIDTH = 1000
HEIGHT = 800
DIMENSIONS = (WIDTH, HEIGHT)


def main():
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    clock = pygame.time.Clock()
    run = True
    p = player_bat(pos_x=10, pos_y=HEIGHT/2, width=10, height=150)
    e = enemy_bat(pos_x=WIDTH-20, pos_y=HEIGHT/2, width=10, height=150)
    b = ball(pos_x=WIDTH/2, pos_y=HEIGHT/2, width = 20)

    while run:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
                break

        # update display and draw
        p.draw(screen)
        e.draw(screen)
        b.draw(screen)

        pygame.display.update()
    
    pygame.quit()

if __name__ == "__main__":
    main()