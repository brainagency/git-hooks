require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative './.env'
require_relative '../core/git_hooks'

Minitest::Reporters.use!
