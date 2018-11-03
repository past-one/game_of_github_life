module GameOfGithubLife
  class DateCalculator
    NUMBER_OF_COLUMNS = 53
    DAYS_IN_WEEK = 7
    DAY = 60 * 60 * 24

    class << self
      # time for top-left cell in contributions calendar for given (or current) year
      def start_date(year = nil)
        now = Time.now
        date = if year
                 Time.new(year, 1, 1, 12) - DAY * DAYS_IN_WEEK
               else
                 Time.new(now.year - 1, now.month, now.day, 12)
               end

        date + DAY * (DAYS_IN_WEEK - date.wday)
      end

      # time for cell with x cells left and y cells down from top-left cell
      # in contributions calendar for given (or current) year
      def date_by_cell(x, y, year: nil)
        unless (0...DAYS_IN_WEEK).cover?(x)
          raise ArgumentError, "x = #{x} should in 0...#{DAYS_IN_WEEK}"
        end
        unless (0...NUMBER_OF_COLUMNS).cover?(y)
          raise ArgumentError, "y = #{y} should in 0...#{NUMBER_OF_COLUMNS}"
        end

        start_date(year) + DAY * (x + DAYS_IN_WEEK * y)
      end
    end
  end
end
