import pygame
import time
import random
from enemy_bat import enemy_bat
from player_bat import player_bat
from bat import bat
from ball import ball
from logic import logic
from draw import draw
from game import game

pygame.font.init()
pygame.display.set_caption("Pong")

WIDTH = 1000
HEIGHT = 800

BALL_VEL = 7
PLAYER_1_BAT_VEL = 10
PLAYER_2_BAT_VEL = 10

text_font = pygame.font.SysFont(None, 36)
text_color = (255, 255, 255)
scores = [0,0]
player_score_pos = (WIDTH // 3, HEIGHT // 3)
enemy_score_pos = (WIDTH - WIDTH // 3, HEIGHT // 3)
message_pos = (WIDTH // 2, HEIGHT // 2)

show_welcome_screen = True
show_game_screen = False
show_end_screen = False

def main():
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    clock = pygame.time.Clock()
    run = True

    player_object = player_bat (pos_x=10, pos_y=HEIGHT//2, width=10, height=150, vel=PLAYER_1_BAT_VEL)
    enemy_object = enemy_bat (pos_x=WIDTH-20, pos_y=HEIGHT//2, width=10, height=150, vel=PLAYER_2_BAT_VEL)    
    ball_object = ball(pos_x=WIDTH/2, pos_y=HEIGHT/2, width = 20, vel=BALL_VEL)

    while run:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
                break

        logic.handle_movement(ball_object,enemy_object,player_object,WIDTH,HEIGHT)
        
        logic.handle_collisions(ball_object,enemy_object,player_object,WIDTH,HEIGHT, scores)
    
        screen.fill("black")

        if show_welcome_screen:
            draw.draw_welcome_message(screen,text_font,text_color,scores,WIDTH,HEIGHT,player_score_pos,enemy_score_pos,message_pos,ball_object,enemy_object,player_object)

            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                    show_game_screen = True
                    show_welcome_screen = False

        if show_game_screen:

            game.restart_game()
            
            draw.draw_game_screen(screen,text_font,text_color,scores,WIDTH,HEIGHT,player_score_pos,enemy_score_pos,message_pos,ball_object,enemy_object,player_object)


        if show_end_screen:
            
            draw.draw_end_screen(screen,text_font,text_color,scores,WIDTH,HEIGHT,player_score_pos,enemy_score_pos,message_pos)

        draw.draw_game_screen(screen, ball_object,enemy_object,player_object,text_font,text_color,scores,WIDTH,HEIGHT,player_score_pos,enemy_score_pos)
        # draw.draw_objects(ball_object,enemy_object,player_object,screen)

        # draw.draw_text(screen,text_font,text_color,scores, WIDTH, HEIGHT, player_score_pos, enemy_score_pos)
        
        # draw.draw_welcome_message(screen, text_font, text_color, scores,WIDTH,HEIGHT,player_score_pos,enemy_score_pos,message_pos)


        pygame.display.update()
        clock.tick(60)
    
    pygame.quit()

if __name__ == "__main__":
    main()