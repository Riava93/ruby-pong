# Paddle Class (Player)
#
# Author: Raven Avalon
# Website: ravenavalon.com
# Version: 1.0
require 'gosu'

class Paddle
	attr_accessor :spawn_x, :spawn_y, :current_y
	attr_reader :section_height, :paddle_height, :paddle_width

	def initialize window
		@section_height = 32
		@paddle_width = 20
		@paddle_height = (641 / 4).round
		@current_y = 200

		@paddle_colour = Gosu::Color.new 0xfff1f1f1

		@image = Gosu::Image.from_text(window, '|', 'Source Code Pro', 160)
	end

	def draw player
		if player == 'player_1'
			@image.draw((1140 * 0.02).round, @current_y, 500)
		elsif player == 'player_2'
			@image.draw(1030, @current_y, 500)
		end
	end

	#  Move our paddle up towards the top of the table object
	#  only if the top boundry is not in our way
	def move_up
		move_succeed = nil

		if any_boundries? 'top'
			move_succeed = false
		else
			move_succeed = true
			@current_y -= 5
		end

		move_succeed
	end

	#  Move our paddle down towards the bottom of the table object
	#  only if the bottom boundry is not in our way
	def move_down
		move_succeed = nil

		if any_boundries? 'bottom'
			move_succeed = false
		else
			move_succeed = true
			@current_y += 5
		end

		move_succeed
	end

	#  Check if we are too close to the top or bottom
	#  Boundries of the table object.
	def any_boundries? direction
		case direction
		when 'top'
			if (@current_y - 5) < -50
				true
			else
				false
			end
		when 'bottom'
			if (@current_y + 5) > 490
				true
			else
				false
			end
		end
	end
end
