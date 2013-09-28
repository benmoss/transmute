require 'aruba/cucumber'

Before do
  set_env('RUBYOPT', "-I ../../lib")
end
