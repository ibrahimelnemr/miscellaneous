from player_bat import player_bat
from enemy_bat import enemy_bat
from ball import ball

class game:
    def restart_game(ball_object: ball, ball_starting_vel: int, enemy_object: enemy_bat, player_object: player_bat, WIDTH: int, HEIGHT: int, scores: list[int]):
        scores[0] = 0
        scores[1] = 0

        ball_object.pos_x = WIDTH // 2
        ball_object.pos_y = HEIGHT // 2

        ball_object.vel = ball_starting_vel


    def stop_game(ball_object: ball, enemy_object: enemy_bat, player_object: player_bat, WIDTH: int, HEIGHT: int, scores: list[int]):
        scores[0] = 0
        scores[1] = 0

        ball_object.pos_x = WIDTH // 2
        ball_object.pos_y = HEIGHT // 2
        
        ball_object.vel = 0


