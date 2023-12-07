import pygame
import time
import random
from enemy_bat import enemy_bat
from player_bat import player_bat
from bat import bat
from ball import ball
from logic import logic
from draw import draw

pygame.font.init()
pygame.display.set_caption("Pong")

WIDTH = 1000
HEIGHT = 800

score_font = pygame.font.SysFont(None, 36)
score_color = (255, 255, 255)
scores = [0,0]
player_score_pos = (WIDTH // 3, HEIGHT // 3)
enemy_score_pos = (WIDTH - WIDTH // 3, HEIGHT // 3)


def main():
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    clock = pygame.time.Clock()
    run = True

    player_object = player_bat (pos_x=10, pos_y=HEIGHT//2, width=10, height=150, vel=10)
    enemy_object = enemy_bat (pos_x=WIDTH-20, pos_y=HEIGHT//2, width=10, height=150, vel=10)    
    ball_object = ball(pos_x=WIDTH/2, pos_y=HEIGHT/2, width = 20, vel=7)

    while run:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
                break

        logic.handle_movement(ball_object,enemy_object,player_object,WIDTH,HEIGHT)
        
        logic.handle_collisions(ball_object,enemy_object,player_object,WIDTH,HEIGHT, scores)
    
        screen.fill("black")
        draw.draw_objects(ball_object,enemy_object,player_object,screen)
        draw.draw_text(screen,score_font,score_color,scores, WIDTH, HEIGHT, player_score_pos, enemy_score_pos)

        pygame.display.update()
        clock.tick(60)
    
    pygame.quit()

if __name__ == "__main__":
    main()