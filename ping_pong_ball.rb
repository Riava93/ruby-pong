# Ping Pong Ball Class
#
# Author: Raven Avalon
# Website: ravenavalon.com
# Version: 1.0
require 'gosu'

class PingPongBall
	attr_accessor :speed_multiplier, :direction, :pos_x, :pos_y
	attr_reader :possible_directions

	#  Set the ping pong ball in the middle of the screen (roughly) and let it
	#  randomly choose which direction it will begin moving on game start.
	def initialize window, position_x = (1140 / 2), position_y = (641 / 2).round
		@possible_directions = ['north_north_west', 'north_west', 'west_west_north', 'west', 'west_west_south', 'south_west', 'south_south_west', 'south_south_east', 'south_east', 'east_east_south', 'east', 'east_east_north', 'north_east', 'north_north_east']

		@image = Gosu::Image.from_text(window, "o", "Source Sans Pro", 100)

		@pos_x = position_x
		@pos_y = position_y
		@direction = possible_directions.sample
	end

	#  When the ping pong ball hits a paddle, the paddle will call this method
	#  to determine which direction the ping pong ball should move in after collision
	def force_direction new_direction
		@direction = new_direction
	end

	# Should bounce off at the exact opposite direction that it
	# was going when it collided with an object.
	def change_direction current_direction = @direction
		if (@pos_y - 4) < -50
			case direction
			when 'north_west' then @direction = 'south_west'
			when 'north_east' then @direction = 'south_east'
			when 'north_north_west' then @direction = 'south_south_west'
			when 'north_north_east' then @direction = 'south_south_east'
			when 'west_west_north' then @direction = 'west_west_south'
			when 'east_east_north' then @direction = 'east_east_south'
			end
		elsif (@pos_y + 4) > 540
			case direction
			when 'south_west' then @direction = 'north_west'
			when 'south_east' then @direction = 'north_east'
			when 'south_south_west' then @direction = 'north_north_west'
			when 'south_south_east' then @direction = 'north_north_east'
			when 'west_west_south' then @direction = 'west_west_north'
			when 'east_east_south' then @direction = 'east_east_north'
			end
		end
	end

	#  Move the ball with given velocity and angle/direction
	#
	#  IMPLEMENT:  Add a check to ensure that the ball can continue moving
	#  in the given direction... use change_direction method...
	def keep_moving direction = @direction
		case direction
		when 'north_west'
			@pos_x -= 4
			@pos_y -= 4
		when 'north_east'
			@pos_x += 4
			@pos_y -= 4
		when 'south_west'
			@pos_x -= 4
			@pos_y += 4
		when 'south_east'
			@pos_x += 4
			@pos_y += 4
		when 'north_north_west'
			@pos_x -= 2
			@pos_y -= 4
		when 'north_north_east'
			@pos_x += 2
			@pos_y -= 4
		when 'south_south_east'
			@pos_x += 2
			@pos_y += 4
		when 'south_south_west'
			@pos_x -= 2
			@pos_y += 4
		when 'east_east_north'
			@pos_x += 4
			@pos_y -= 2
		when 'east_east_south'
			@pos_x += 4
			@pos_y += 2
		when 'west_west_north'
			@pos_x -= 4
			@pos_y -= 2
		when 'west_west_south'
			@pos_x -= 4
			@pos_y += 2
		when 'east'
			@pos_x += 4
		when 'west'
			@pos_x -= 4
		end
	end

	def random_direction
		@direction = possible_directions.sample
	end

	#  Method for drawing the ball on the screen in the gosu window object
	#  This places it at it's starting x and y coordinates, with 50 z index
	def draw
		@image.draw(@pos_x, @pos_y, 50)
	end
end
