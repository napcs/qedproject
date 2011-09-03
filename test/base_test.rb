require 'project_test_helper'

class Foo < QEDProject::Libraries::Base
 library :foo
end

class Bar < QEDProject::Libraries::Base
 library :bar
end

class BaseTest < Test::Unit::TestCase

   def test_registers_a_library_by_definition
     assert_equal QEDProject::Libraries::Base.libs[:foo], Foo
   end
   
   def test_registers_multiple_libraries_by_definition
     assert_equal QEDProject::Libraries::Base.libs[:foo], Foo
     assert_equal QEDProject::Libraries::Base.libs[:bar], Bar
   end

end
