#!/usr/bin/env ruby

require 'gosu'
require_relative 'ping_pong_ball.rb'
require_relative 'paddle.rb'
require_relative 'score.rb'
class PongGame < Gosu::Window

	def initialize 
		super 1140, 641, true
		self.caption = 'Raven\'s Game of Pong'

		@bgm = Gosu::Song.new self, 'bg_music.mp3'
		@bgm.play true
		
		@background_colour = Gosu::Color.new 0xff1a1a1a
		@object_colour = Gosu::Color.new 0xffefefef
		@font = Gosu::Font.new(self, Gosu::default_font_name, 50)
		@diagnostic = Gosu::Font.new(self, "Source Code Pro", 24)
		@end_font = Gosu::Font.new(self, Gosu::default_font_name, 30)

		@ball = PingPongBall.new self
		@paddle_1 = Paddle.new self
		@paddle_2 = Paddle.new self 
		@score = Score.new

		@dividing_line = 1140 / 2

		@game_over = false

		@paddle_1_x = (1140 * 0.02).round + 20

		@paddle_2_x = 1035
	end
 
	def update
		if @score.player_1 == 6
			@game_over = true
			@the_winner = 'player_1'
		elsif @score.player_2 == 6
			@game_over = true
			@the_winner = 'player_2'
		end

		if @game_over == true
			self.draw_game_over_screen @the_winner

			if button_down? Gosu::KbEscape
				close
			end
		else
			@ball.change_direction
			@ball.keep_moving
	
			if @ball.pos_x < -30
				@score.add_point 'player_2'
				@ball.pos_x = 1140 / 2
				@ball.pos_y = (641 / 2).round
				@ball.random_direction
			elsif @ball.pos_x > 1140
				@score.add_point 'player_1'
				@ball.pos_x = 1140 / 2
				@ball.pos_y = (641 / 2).round
				@ball.random_direction
			end
	
			if button_down? Gosu::KbW or button_down? Gosu::KbK
				@paddle_1.move_up
			elsif button_down? Gosu::KbS or button_down? Gosu::KbJ
				@paddle_1.move_down
			end
	
			if button_down? Gosu::KbUp
				@paddle_2.move_up
			elsif button_down? Gosu::KbDown
				@paddle_2.move_down
			end
	
			if button_down? Gosu::KbEscape
				close
			end
			
			if @ball.pos_x > @paddle_2_x
				nil
			elsif @ball.pos_x + 15 > @paddle_2_x
				if ( (@paddle_2.current_y)..(@paddle_2.current_y + @paddle_1.paddle_height) ).include? @ball.pos_y
					new_direction = ['south_south_west', 'south_west', 'west', 'north_north_west', 'north_west'].sample
					@ball.force_direction new_direction
				end
			end
			
			if @ball.pos_x < @paddle_1_x
				nil
			elsif @ball.pos_x - 15 < @paddle_1_x
				if ( ( @paddle_1.current_y )..( @paddle_1.current_y + @paddle_1.paddle_height ) ).include? @ball.pos_y
					new_direction = ['north_north_east', 'north_east', 'east', 'south_south_east', 'south_east'].sample
					@ball.force_direction new_direction
				end
			end
		end
	end

	def draw
		# Softer Background
		draw_quad(0, 0, @background_colour,
				  1140, 0, @background_colour,
				  0, 641, @background_colour,
				  1140, 641, @background_colour)

		# Dividng line
		draw_quad(@dividing_line, 0, @object_colour,
				  @dividing_line + 5, 0, @object_colour,
				  @dividing_line, 641, @object_colour,
				  @dividing_line + 5, 641, @object_colour)

		# Player 1 score
		if @score.player_1 > 9
			@font.draw("#{@score.player_1}", @dividing_line - 170, 20, 5, 3)
		else
			@font.draw("#{@score.player_1}", @dividing_line - 100, 20, 5, 3)
		end

		# Player 2 score
		@font.draw("#{@score.player_2}", @dividing_line + 30, 20, 5, 3)

		# Draw the ball
		@ball.draw

		#  What direction are we going? (Diagnositcs)
		#@diagnostic.draw("#{@ball.direction}", 100, 600, 5, 3)
		
		#  Where should the ping pong ball be starting
		#@diagnostic.draw("#{@ball.pos_y}", 100, 600, 5, 3)

		# Draw paddle 1
		@paddle_1.draw 'player_1'

		# Draw paddle 2
		@paddle_2.draw 'player_2'

		#  If Game over, draw winning screen
		if @game_over == true && @winner_found == true
			draw_quad(0, 0, @background_colour,
					  1140, 0, @background_colour,
					  0, 641, @background_colour,
					  1140, 641, @background_colour)
			@winning_screen.draw(285, 100, 1000)
			
			@end_font.draw("Press ESC to quit", 450, 250, 1000)
		end
	end

	def draw_game_over_screen winner
		case winner
		when 'player_1'
			@winning_text = 'Player 1 Wins!'
		when 'player_2'
			@winning_text = 'Player 2 Wins!'
		end

		@winner_found = true

		@winning_screen = Gosu::Image.from_text(self, "#{@winning_text}", 'Source Code Pro', 100) 
	end
end

window = PongGame.new
window.show
