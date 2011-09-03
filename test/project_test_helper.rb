require 'rubygems'
require 'test/unit'
require 'lib/qedproject'
require 'pathname'

class Test::Unit::TestCase
  class << self
    def abstract
      self.class_eval do
        def test_default
        end
      end
    end
  end
end

class ProjectTestCase < Test::Unit::TestCase
  
  abstract
  
  def setup
    @folder = "tmpproject"
  end
  
  def teardown
    FileUtils.rm_rf @folder
  end
  
end