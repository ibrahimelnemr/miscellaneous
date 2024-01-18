import pygame
from player_bat import player_bat
from enemy_bat import enemy_bat
from ball import ball

pygame.font.init()

class game2:
    # static attributes
    WIDTH=1000
    HEIGHT=1000
    BALL_VEL=7
    text_font: pygame.font.SysFont("arial", 36)    
    text_color = (255, 255, 255)
    scores = [0, 0]
    player_score_pos = (WIDTH // 3, HEIGHT // 3)
    enemy_score_pos = (WIDTH - WIDTH // 3, HEIGHT // 3)
    message_pos = (WIDTH // 2, HEIGHT // 2)

    screen = pygame.display.set_mode((WIDTH,HEIGHT))
    
    player_object = player_bat(
        pos_x=10,
        pos_y=HEIGHT//2,
        width=10,
        height=150,
        vel=10)

    enemy_object = enemy_bat(
        pos_x=WIDTH-20,
        pos_y=HEIGHT//2,
        width=10,
        height=150,
        vel=10)

    ball_object = ball(
        pos_x=WIDTH/2,
        pos_y=HEIGHT/2,
        width=20,
        vel=BALL_VEL)
    @classmethod
    def restart_game(cls):
        cls.scores[0] = 0
        cls.scores[1] = 0

        cls.ball_object.pos_x = cls.WIDTH // 2
        cls.ball_object.pos_y = cls.HEIGHT // 2

        cls.ball_object.vel = cls.BALL_VEL

    @classmethod
    def stop_game(cls):
        cls.scores[0] = 0
        cls.scores[1] = 0

        cls.ball_object.pos_x = cls.WIDTH // 2
        cls.ball_object.pos_y = cls.HEIGHT // 2
        
        cls.ball_object.vel = 0
