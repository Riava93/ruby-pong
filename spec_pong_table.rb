require 'rspec'
require_relative './pong_table.rb'
require_relative './paddle.rb'
require_relative './ping_pong_ball.rb'
require_relative './score.rb'

describe 'PongGame' do

	let(:table) { PongTable.new }

	context 'Paddle (player)' do

		subject { Paddle.new }

		it 'Should respond to proper methods' do
			expect(subject.respond_to? :spawn_x).to eq true
			expect(subject.respond_to? :spawn_y).to eq true
			expect(subject.respond_to? :current_y).to eq true
			expect(subject.respond_to? :move_up).to eq true
			expect(subject.respond_to? :move_down). to eq true
			expect(subject.respond_to? :any_boundries?).to eq true
		end

		it 'Should return true if too close to top boundry' do
			subject.current_y = 3
			expect(subject.any_boundries? 'top').to eq true
		end

		it 'Should return false if top boundry is farther away' do
			subject.current_y = 50
			expect(subject.any_boundries? 'top').to eq false
		end

		it 'Should return true if bottom boundry is too close' do
			subject.current_y = 639
			expect(subject.any_boundries? 'bottom').to eq true
		end

		it 'Should return false if bottom boundry is farther away' do
			subject.current_y = 500
			expect(subject.any_boundries? 'bottom').to eq false
		end

		context 'Paddle sections' do

			it 'Should have a height equal to 1 / 5 of the paddle height' do
				expect(subject.section_height).to eq 32
			end

		end

		context 'Movement controls' do

			it 'Should be able to move up' do
				subject.current_y = 50
				subject.move_up
				expect(subject.current_y).to eq 48
			end

			it 'Should not exceed top boundry' do
				subject.current_y = 3
				expect(subject.move_up).to eq false
			end

			it 'Should be able to move down' do
				subject.current_y = 50
				subject.move_down
				expect(subject.current_y).to eq 52
			end

			it 'Should not exceed bottom boundry' do
				subject.current_y = 639
				expect(subject.move_down).to eq false
			end
		end  # End Paddle: Movement controlls context
	end  # End paddle context

	context 'Ping Pong Ball: ' do

		subject { PingPongBall.new }

		it 'Should respond to correct values' do
			expect(subject.respond_to? :speed_multiplier).to eq true
			expect(subject.respond_to? :direction).to eq true
			expect(subject.respond_to? :pos_x).to eq true
			expect(subject.respond_to? :pos_y).to eq true
			expect(subject.respond_to? :change_direction).to eq true
			expect(subject.respond_to? :force_direction).to eq true
		end

		it 'Should be able to forceably change direction of the ball' do
			subject.direction = 'north_west'
			expect(subject.direction).to eq 'north_west'

			subject.force_direction 'east'
			expect(subject.direction).to eq 'east'
		end

		it 'Should choose a direction to go' do
			expect(subject.direction.nil?).not_to eq true
		end

		context 'Change directions: ' do

			subject { PingPongBall.new }

			context 'When hitting the top boundry' do

				it 'should change to south west when moving north west' do
					# Force ball to be close to top boundry
					subject.pos_y = 3
					subject.direction = 'north_west'

					subject.change_direction
					expect(subject.direction).to eq 'south_west'
				end

				it 'Should change to south east when moving north east' do
					# Force ball to be close to top boundry
					subject.pos_y = 3
					subject.direction = 'north_east'

					subject.change_direction
					expect(subject.direction).to eq 'south_east'
				end

				it 'Should move south south west when moving north north west' do
					subject.pos_y = 3
					subject.direction = 'north_north_west'

					subject.change_direction
					expect(subject.direction).to eq 'south_south_west'
				end

				it 'Should move south south east when moving north north east' do
					subject.pos_y = 3
					subject.direction = 'north_north_east'

					subject.change_direction
					expect(subject.direction).to eq 'south_south_east'
				end

				it 'Should move west west south when moving west west north' do
					subject.pos_y = 3
					subject.direction = 'west_west_north'

					subject.change_direction
					expect(subject.direction).to eq 'west_west_south'
				end

				it 'Should move east east south when moving east east north' do
					subject.pos_y = 3
					subject.direction = 'east_east_north'

					subject.change_direction
					expect(subject.direction).to eq 'east_east_south'
				end

			end

			context 'When hitting bottom boundry' do

				it 'Should move north west when moving south west' do
					# Force ball to be close to top boundry
					subject.pos_y = 638
					subject.direction = 'south_west'

					subject.change_direction
					expect(subject.direction).to eq 'north_west'
				end

				it 'Should move north east when moving south east' do
					subject.pos_y = 638
					subject.direction = 'south_east'

					subject.change_direction
					expect(subject.direction).to eq 'north_east'
				end

				it 'Should move north north west when moving south south west' do
					subject.pos_y = 638
					subject.direction = 'south_south_west'

					subject.change_direction
					expect(subject.direction).to eq 'north_north_west'
				end

				it 'Should move north north east when moving south south east' do
					subject.pos_y = 638
					subject.direction = 'south_south_east'

					subject.change_direction
					expect(subject.direction).to eq 'north_north_east'
				end

				it 'Should move west west north when moving west west south' do
					subject.pos_y = 638
					subject.direction = 'west_west_south'

					subject.change_direction
					expect(subject.direction).to eq 'west_west_north'
				end

				it 'Should move east east north when moving east east south' do
					subject.pos_y = 638
					subject.direction = 'east_east_south'

					subject.change_direction
					expect(subject.direction).to eq 'east_east_north'
				end
			end
		end

		context 'Movement controls' do

			subject { PingPongBall.new }

			it 'Should move north west' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'north_west'
				subject.keep_moving
				expect(subject.pos_x).to eq 566
				expect(subject.pos_y).to eq 316
			end

			it 'should move north east' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'north_east'
				subject.keep_moving
				expect(subject.pos_x).to eq 574
				expect(subject.pos_y).to eq 316
			end

			it 'Should move south west' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'south_west'
				subject.keep_moving
				expect(subject.pos_x).to eq 566
				expect(subject.pos_y).to eq 324
			end

			it 'Should be able to move to the south east' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'south_east'
				subject.keep_moving
				expect(subject.pos_x).to eq 574
				expect(subject.pos_y).to eq 324
			end

			it 'Should be able to move to the north north west' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'north_north_west'
				subject.keep_moving
				expect(subject.pos_x).to eq 568
				expect(subject.pos_y).to eq 316
			end

			it 'Should be able to move to the north north east' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'north_north_east'
				subject.keep_moving
				expect(subject.pos_x).to eq 572
				expect(subject.pos_y).to eq 316
			end

			it 'Should be able to move to the south south east' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'south_south_east'
				subject.keep_moving
				expect(subject.pos_x).to eq 572
				expect(subject.pos_y).to eq 324
			end

			it 'Should be able to move to the south south west' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'south_south_west'
				subject.keep_moving
				expect(subject.pos_x).to eq 568
				expect(subject.pos_y).to eq 324
			end

			it 'Should move to the east east north' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'east_east_north'
				subject.keep_moving
				expect(subject.pos_x).to eq 574
				expect(subject.pos_y).to eq 318
			end

			it 'Should move to the east east south' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'east_east_south'
				subject.keep_moving
				expect(subject.pos_x).to eq 574
				expect(subject.pos_y).to eq 322
			end

			it 'Should move to the west west north' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'west_west_north'
				subject.keep_moving
				expect(subject.pos_x).to eq 566
				expect(subject.pos_y).to eq 318
			end

			it 'Should move to the west west south' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'west_west_south'
				subject.keep_moving
				expect(subject.pos_x).to eq 566
				expect(subject.pos_y).to eq 322
			end

			it 'Should move to the east' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'east'
				subject.keep_moving
				expect(subject.pos_x).to eq 574
				expect(subject.pos_y).to eq 320
			end

			it 'Should move to the west' do
				expect(subject.pos_x).to eq 570
				expect(subject.pos_y).to eq 320

				subject.direction = 'west'
				subject.keep_moving
				expect(subject.pos_x).to eq 566
				expect(subject.pos_y).to eq 320
			end
		end
	end  # End ping pong ball context

	context 'Score Keeper: ' do

		subject { Score.new }

		it 'should respond to proper values' do
			expect(subject.respond_to? :player_1).to eq true
			expect(subject.respond_to? :player_2).to eq true
			expect(subject.respond_to? :add_point).to eq true
		end

		it 'Should add a point to the player 1' do
			expect(subject.player_1).to eq 0

			subject.add_point 'player_1'
			expect(subject.player_1).to eq 1
		end

		it 'Should add a point to the player 2' do
			expect(subject.player_2).to eq 0

			subject.add_point 'player_2'
			expect(subject.player_2).to eq 1
		end
	end  # End of score context
end
