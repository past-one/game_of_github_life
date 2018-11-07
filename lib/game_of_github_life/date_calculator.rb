# frozen_string_literal: true

module GameOfGithubLife
  # Calculates time for commits to take a right cells in contribution calendar
  class DateCalculator
    NUMBER_OF_COLUMNS = 53
    DAYS_IN_WEEK = 7
    DAY = 60 * 60 * 24

    class << self
      # Time for top-left cell in contributions calendar for given (or current) year
      def start_date(year = nil)
        now = Time.now
        date = if year
                 Time.new(year, 12, 31, 12) - DAY * DAYS_IN_WEEK * NUMBER_OF_COLUMNS
               else
                 Time.new(now.year - 1, now.month, now.day, 12)
               end

        date + DAY * (DAYS_IN_WEEK - date.wday)
      end

      # Time for cell with x_coord cells down and y_coord cells right from top-left cell
      def date_by_cell(x_coord, y_coord, year: nil)
        unless (0...DAYS_IN_WEEK).cover?(x_coord)
          raise ArgumentError, "x_coord = #{x_coord} should be in 0...#{DAYS_IN_WEEK}"
        end
        unless (0...NUMBER_OF_COLUMNS).cover?(y_coord)
          raise ArgumentError, "y_coord = #{y_coord} should be in 0...#{NUMBER_OF_COLUMNS}"
        end

        start_date(year) + DAY * (x_coord + DAYS_IN_WEEK * y_coord)
      end
    end
  end
end
