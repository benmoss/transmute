source 'https://rubygems.org'

# Specify your gem's dependencies in transmute.gemspec
gemspec

group :development, :test do
  gem 'cucumber'
  gem 'aruba'
  gem 'rspec'
end

group :development do
  gem 'rake'
end

group :metrics do
  platforms :ruby_19, :ruby_20 do
    gem 'mutant', git: 'https://github.com/mbj/mutant.git'
  end
end
