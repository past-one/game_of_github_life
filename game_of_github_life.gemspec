lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_of_github_life/version'

Gem::Specification.new do |spec|
  spec.name = 'game_of_github_life'
  spec.version = GameOfGithubLife::VERSION
  spec.authors = ['past-one']
  spec.email = ['mrpast@live.com']

  spec.summary = "Play Conway's game of life in Github"
  spec.description = "Play Conway's game of life in Github's contribution calendar"
  spec.homepage = 'https://github.com/past-one/game_of_github_life'
  spec.license = 'MIT'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.executables << 'game_of_github_life'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'timecop', '~> 0'
end
