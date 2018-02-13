require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative './.env'
require_relative '../core/git_hooks'

require 'byebug'

Minitest::Reporters.use!
