require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha'
require 'mocha/mini_test'

require_relative './.env'
require_relative '../core/git_hooks'

require 'byebug'

Minitest::Reporters.use!
