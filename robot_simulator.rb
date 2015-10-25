class Robot
  attr_accessor :bearing, :coordinates

  DIRECTIONS_HASH = { :north => 0, :east => 1, :south => 2, :west => 3 }

  def orient(direction)
    if [:north, :south, :east, :west].include? direction
      @bearing = direction
    else
      raise(ArgumentError, "Please only use north, south, east, or west") unless @bearing
    end
  end

  def turn_right
    if DIRECTIONS_HASH[@bearing] == 3
      self.orient(:north)
    else
      self.orient(DIRECTIONS_HASH.key(DIRECTIONS_HASH[@bearing] + 1))
    end
  end

  def turn_left
    if DIRECTIONS_HASH[@bearing] == 0
      self.orient(:west)
    else
      self.orient(DIRECTIONS_HASH.key(DIRECTIONS_HASH[@bearing] - 1))
    end
  end

  def at(x, y)
    self.coordinates = [x, y]
  end

  def advance
    if @bearing == :north
      self.coordinates = [self.coordinates[0], self.coordinates[1] + 1]
    elsif @bearing == :east
      self.coordinates = [self.coordinates[0] + 1, self.coordinates[1]]
    elsif @bearing == :south
      self.coordinates = [self.coordinates[0], self.coordinates[1] - 1]
    elsif @bearing == :west
      self.coordinates = [self.coordinates[0] - 1, self.coordinates[1]]
    end
  end

end

class Simulator
  def instructions(directions)
    directions = directions.split('')
    commands = []
    directions.each do |d|
      if d == 'L'
        commands << :turn_left
      elsif d == 'R'
        commands << :turn_right
      elsif d == 'A'
        commands << :advance
      end
    end
    commands
  end

  def place(robot, location)
    robot.at(location[:x], location[:y])
    robot.orient(location[:direction])
  end

  def evaluate(robot, directions)
    instructions(directions).each do |instruction|
      robot.send(instruction)
    end
  end

end