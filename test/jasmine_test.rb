require 'project_test_helper'

class JasmineTest < ProjectTestCase
  
  def test_no_tests_when_not_specified
    p = QEDProject::Project.new(@folder)
    p.generate
      assert !File.exist?(File.join(@folder, "spec"))
  end
  
  def test_includes_test_folder_skeleton_when_specified
    p = QEDProject::Project.new(@folder, :testing => true)
    p.generate
    assert File.exist? File.join(@folder, "spec")
    assert File.exist? File.join(@folder, "spec", "lib")
    assert File.exist? File.join(@folder, "spec", "suite.html")
  end
  
  def test_includes_js_test_when_testing_without_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true)
    p.generate
    assert File.exist? File.join(@folder, "spec", "sampleSpec.js")
  end
  
  def test_includes_coffeescript_test_when_testing_with_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true, :coffeescript => true)
    p.generate
    source = Pathname.new(File.join(@folder, "spec", "sampleSpec.coffee")).read
    assert source.include?("describe \"A sample spec\", ->")
  end
  
  def test_guardfile_includes_watch_on_spec_folder_when_testing_with_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true, :coffeescript => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert source.include?('guard "coffeescript", :input => "spec", :output => "spec"')
  end
  
  def test_guardfile_includes_watch_on_spec_folder_when_testing_with_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true, :coffeescript => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert source.include?('guard "coffeescript", :input => "spec", :output => "spec"')
  end
  
  
  
  
end