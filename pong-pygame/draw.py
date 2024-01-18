import ball
import pygame
from enemy_bat import enemy_bat
from player_bat import player_bat
from ball import ball

class draw:
    
    def draw_game_screen(screen: pygame.Surface, 
                             text_font: pygame.font.SysFont, 
                             text_color: tuple[int,int,int], 
                             scores: list[int], 
                             WIDTH: int, 
                             HEIGHT: int, 
                             player_score_pos: tuple[int,int], 
                             enemy_score_pos: tuple[int,int], 
                             message_pos: tuple[int,int],
                             ball_object: ball, 
                             enemy_object: enemy_bat, player_object: player_bat):
        player_score_text_surface = text_font.render(f"Player score: {scores[0]}", True, text_color)
        enemy_score_text_surface = text_font.render(f"Enemy score: {scores[1]}", True, text_color)

        player_score_text_surface_rect = player_score_text_surface.get_rect()
        enemy_score_text_surface_rect = enemy_score_text_surface.get_rect()


        player_score_text_surface_rect.center = player_score_pos
        enemy_score_text_surface_rect.center = enemy_score_pos

        screen.blit(player_score_text_surface, player_score_text_surface_rect)
        screen.blit(enemy_score_text_surface, enemy_score_text_surface_rect)

        player_object.draw(screen)
        enemy_object.draw(screen)
        ball_object.draw(screen)

    def draw_welcome_message(screen: pygame.Surface, 
                             text_font: pygame.font.SysFont, 
                             text_color: tuple[int,int,int], 
                             message_pos: tuple[int,int]):
        message = "Welcome to Pong! Press any key to begin or q to quit."
        message_text_surface = text_font.render(message,True, text_color)
        message_text_surface_rect = message_text_surface.get_rect()
        
        message_text_surface_rect.center = message_pos

        screen.blit(message_text_surface, message_text_surface_rect)

    def draw_end_screen(screen: pygame.Surface, 
                             text_font: pygame.font.SysFont, 
                             text_color: tuple[int,int,int], 
                             scores: list[int], 
                             WIDTH: int, 
                             HEIGHT: int, 
                             player_score_pos: tuple[int,int], 
                             enemy_score_pos: tuple[int,int], 
                             message_pos: tuple[int,int],
                             ball_object: ball, 
                             enemy_object: enemy_bat, player_object: player_bat):
        message = "Game over. "
        if scores[0] > scores [1]:
            message += "Player 1 wins. "
        else:
            message += "Player 2 wins. "
        
        message += "\nPress any key to play again."
        
        message_text_surface = text_font.render(message,True, text_color)
        message_text_surface_rect = message_text_surface.get_rect()
        
        message_text_surface_rect.center = message_pos

        screen.blit(message_text_surface, message_text_surface_rect)