# frozen_string_literal: true

module GameOfGithubLife
  # Performs git commands in specified repository
  class GitExecutor
    attr_reader :path

    def initialize(path)
      @path = File.expand_path("#{path}/.git")
    end

    def commit(date, msg = 'draw')
      `git --git-dir=#{path} commit --allow-empty -m "#{msg}" --date "#{date}"`
    end

    def push
      `git --git-dir=#{path} push --force -u origin master`
    end
  end
end
