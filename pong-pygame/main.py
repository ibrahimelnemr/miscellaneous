import pygame
import time
import random
from enemy_bat import enemy_bat
from player_bat import player_bat
from bat import bat
from ball import ball
from logic import logic


pygame.font.init()

WIDTH = 1000
HEIGHT = 800
DIMENSIONS = (WIDTH, HEIGHT)


def main():
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    clock = pygame.time.Clock()
    run = True

    player_object = player_bat (
        pos_x=10, 
        pos_y=HEIGHT//2, 
        width=10, 
        height=150,
        vel=5
        )
    
    enemy_object = enemy_bat (
        pos_x=WIDTH-20, 
        pos_y=HEIGHT//2, 
        width=10, 
        height=150,
        vel=5
        )
    
    ball_object = ball(
        pos_x=WIDTH/2,
        pos_y=HEIGHT/2,
        width = 20,
        vel=7
    )

    while run:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
                break

        logic.handle_movement(ball_object,enemy_object,player_object,WIDTH,HEIGHT)
        logic.handle_collisions(ball_object,enemy_object,player_object,WIDTH,HEIGHT)
    
        screen.fill("black")

        player_object.draw(screen)
        enemy_object.draw(screen)
        ball_object.draw(screen)

        pygame.display.update()
        clock.tick(60)
    
    pygame.quit()

if __name__ == "__main__":
    main()