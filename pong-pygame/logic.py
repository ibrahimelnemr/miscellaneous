import ball
import pygame
from enemy_bat import enemy_bat
from player_bat import player_bat

class logic:

    def handle_movement(ball_object: ball, enemy_object: enemy_bat, player_object: player_bat, WIDTH: int, HEIGHT: int):
        keys = pygame.key.get_pressed()

        # movement
        if keys[pygame.K_UP] and player_object.pos_y > 0:
            player_object.move("UP")
        if keys[pygame.K_DOWN] and player_object.pos_y < HEIGHT - player_object.height:
            player_object.move("DOWN")
        ball_object.move()
        enemy_object.move()

    def handle_collisions(ball_object: ball, enemy_object: enemy_bat, player_object: player_bat, WIDTH: int, HEIGHT: int):
        

        if ball_object.pos_x > WIDTH:
            ball_object.pos_x = 0
            # ball_object.dir_x *= -1
        if ball_object.pos_x < 0:
            ball_object.pos_x = WIDTH
            # ball_object.dir_x *= -1
        
        if ball_object.pos_y > HEIGHT or ball_object.pos_y < 0:
            ball_object.dir_y *= -1

        # if enemy_object.pos_y < ball_object.pos_y:
        #     enemy_object.dir_y *= -1
        # elif enemy_object.pos_y > ball_object.pos_y:
        #     enemy_object.dir_y *= -1

        if enemy_object.pos_y > HEIGHT or enemy_object.pos_y < 0:
            enemy_object.dir_y *= -1

        if ball_object.pos_x == player_object.pos_x + player_object.width and ball_object.pos_y in range(player_object.pos_y, player_object.pos_y + player_object.height): 
            ball_object.dir_x *= -1

        if ball_object.pos_x == enemy_object.pos_x and ball_object.pos_y in range(enemy_object.pos_y, enemy_object.pos_y + enemy_object.height): 
            ball_object.dir_x *= -1
