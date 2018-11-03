require_relative 'game_of_github_life/date_calculator'
require_relative 'game_of_github_life/game'
require_relative 'game_of_github_life/git_executor'
require_relative 'game_of_github_life/version'

module GameOfGithubLife
  # first and last columns could include another year, so skip it
  NUMBER_OF_COLUMNS = DateCalculator::NUMBER_OF_COLUMNS - 2
  NUMBER_OF_ROWS = DateCalculator::DAYS_IN_WEEK

  #
  # ...................................................
  # ...................................................
  # ...................................................
  # 000000000000000000000000000000000000000000000000000
  # ...................................................
  # ...................................................
  # ...................................................
  #
  START_FIELD = [
      ([0] * NUMBER_OF_COLUMNS).freeze,
      ([0] * NUMBER_OF_COLUMNS).freeze,
      ([0] * NUMBER_OF_COLUMNS).freeze,
      ([1] * NUMBER_OF_COLUMNS).freeze,
      ([0] * NUMBER_OF_COLUMNS).freeze,
      ([0] * NUMBER_OF_COLUMNS).freeze,
      ([0] * NUMBER_OF_COLUMNS).freeze,
  ].freeze

  # 1969 days are invalid dates for git
  START_YEAR = 1970

  module_function

  def play(path, end_year)
    end_year ||= Time.now.year
    game = Game.new(START_FIELD)
    executor = GitExecutor.new(path)
    year = START_YEAR

    commit_field(executor, START_FIELD, START_YEAR)

    while year < end_year && !game.ended?
      field = game.next
      year += 1
      commit_field(executor, field, year)
    end

    executor.push
    puts('done')
  end

  def commit_field(executor, field, year)
    puts(year)
    ppp(field)
    iterate_alive_cells(field) do |x, y|
      date = DateCalculator.date_by_cell(x, y + 1, year: year)
      executor.commit(date, "#{year}:#{x}:#{y}")
    end
  end

  def iterate_alive_cells(field)
    field.each_with_index.map do |row, x|
      row.each_with_index.map do |value, y|
        yield x, y if value == 1
      end
    end
  end

  def ppp(field)
    puts('---')
    puts(field.map { |row| row.map { |cell| cell == 1 ? '#' : ' ' }.join('') })
    puts('---')
  end
end
