import pygame
import time
import random
pygame.font.init()

WIDTH = 1000
HEIGHT = 800
DIMENSIONS = (WIDTH, HEIGHT)

WIN = pygame.display.set_mode(DIMENSIONS)


def draw():
    WIN.blit()
    pygame.display.update()

def main():
    run = True

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            run = False
            break

    while run:
        pygame.display.update()
    
    pygame.quit()

if __name__ == "__main__":
    main()