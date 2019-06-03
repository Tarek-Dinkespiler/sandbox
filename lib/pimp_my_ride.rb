require "pry"

class Car
  ARRAY_OF_DIRECTIONS = %i(north east south west).freeze
  attr_accessor :brand, :color, :number_of_wheels, :direction, :total_distance

  def initialize(brand:, color:)
    @brand = brand
    @color = color
    @number_of_wheels = 4
    @direction = :north
    @total_distance = 0
  end

  def perform
    loop do
      ask_driver_if_direction_is_ok
      direction_is_ok(gets.chomp) ? how_far_are_we_going : what_way_should_we_turn

      break if @total_distance > 100
    end

    puts "CONGRATULATIONS !"
    puts "You've driven over 100km"
  end

  def ask_driver_if_direction_is_ok
    puts "You are currently headed #{@direction}."
    puts "Press 'y' if you are satisfied with this direction (else, any other key will do) :"
  end

  def direction_is_ok(key)
    key == "y"
  end

  def how_far_are_we_going
    puts "You claim to be satisfied with your current direction."
    puts "Input the number of kilometers you wish to drive in this direction :"
    drive_for(gets.chomp)
  end

  def drive_for(distance)
    @total_distance += distance.to_i
  end

  def what_way_should_we_turn
    puts "Press 'l' if you want to turn left."
    puts "Press 'r' if you want to turn right."
    puts "input :"
    set_new_direction(gets.chomp)
  end

  def set_new_direction(turn)
    case turn
    when "r" then turn(:right)
    when "l" then turn(:left)
    else
      puts "I didn't quite catch your input."
      what_way_should_we_turn
    end
  end

  def turn(direction)
    operation = case direction
                when :right then :+
                when :left then :-
                else
                  puts "Unknown direction"
                end
    index = ARRAY_OF_DIRECTIONS.index(@direction).send(operation, 1)
    @direction = ARRAY_OF_DIRECTIONS.at(index)
  end
end

binding.pry