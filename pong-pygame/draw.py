import ball
import pygame
from enemy_bat import enemy_bat
from player_bat import player_bat
from ball import ball

class draw:
    def draw_objects(ball_object: ball, enemy_object: enemy_bat, player_object: player_bat, screen: pygame.Surface):
        player_object.draw(screen)
        enemy_object.draw(screen)
        ball_object.draw(screen)
    def draw_text(screen: pygame.Surface, score_font: pygame.font.SysFont, score_color: tuple[int,int,int], scores: list[int], WIDTH: int, HEIGHT: int, player_score_pos: tuple[int,int], enemy_score_pos: tuple[int,int]):
        player_score_text_surface = score_font.render(f"Player score: {scores[0]}", True, score_color)
        enemy_score_text_surface = score_font.render(f"Enemy score: {scores[1]}", True, score_color)

        player_score_text_surface_rect = player_score_text_surface.get_rect()
        enemy_score_text_surface_rect = enemy_score_text_surface.get_rect()


        player_score_text_surface_rect.center = player_score_pos
        enemy_score_text_surface_rect.center = enemy_score_pos

        screen.blit(player_score_text_surface, player_score_text_surface_rect)
        screen.blit(enemy_score_text_surface, enemy_score_text_surface_rect)