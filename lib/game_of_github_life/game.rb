module GameOfGithubLife
  class Game
    def self.field_footprint(field)
      field.map(&:join).join.to_i(2)
    end

    attr_reader :x_size
    attr_reader :y_size
    attr_accessor :step

    def initialize(field)
      @field = field
      @x_size = 0..field.length - 1
      @y_size = 0..field.first.length - 1
      @prev_prev_footprint = 0
      @previous_footprint = 0
      @step = 0
      check_end
    end

    def next
      return field if ended?

      self.step += 1

      self.field = field.each_with_index.map do |row, x|
        row.each_with_index.map do |prev, y|
          sum = neighbors(x, y).sum
          ((3 - prev)..3).cover?(sum) ? 1 : 0
        end
      end

      check_end

      field
    end

    def ended?
      ended
    end

    def neighbors(x, y)
      [
          [x - 1, y - 1],
          [x - 1, y],
          [x - 1, y + 1],
          [x, y - 1],
          [x, y + 1],
          [x + 1, y - 1],
          [x + 1, y],
          [x + 1, y + 1],
      ].select { |(a, b)| x_size.cover?(a) && y_size.cover?(b) }
          .map { |(a, b)| field[a][b] }
    end

    protected

    attr_accessor :field
    attr_accessor :ended
    attr_accessor :previous_footprint
    attr_accessor :prev_prev_footprint

    private

    def check_end
      return if ended

      footprint = self.class.field_footprint(field)
      if [previous_footprint, prev_prev_footprint].include?(footprint)
        self.ended = true
      else
        self.prev_prev_footprint = previous_footprint
        self.previous_footprint = footprint
      end
    end
  end
end
