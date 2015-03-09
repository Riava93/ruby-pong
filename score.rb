# Score class
#
# Author: Raven Avalon
# Website: ravenavalon.com
# version: 1.0

class Score
	attr_reader :player_1, :player_2

	#  Start both players off at 0 points
	def initialize player_1 = 0, player_2 = 0
		@player_1 = player_1
		@player_2 = player_2
	end

	#  Add a point to the specified player. The PongGame class will
	#  do a check to see if the ping pong ball has collided with
	#  the far left, or far right boundry, then award the proper player
	#  with a point.
	def add_point player
		case player
		when 'player_1'
			@player_1 += 1
		when 'player_2'
			@player_2 += 1
		end
	end
end
