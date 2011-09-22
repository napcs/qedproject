require 'project_test_helper'

class CoffeescriptTest < ProjectTestCase
  def test_creates_coffeescript_folder_with_coffeescript
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    assert File.exist?(File.join(@folder, "coffeescripts"))
  end
  
  def test_creates_coffeescript_file_with_coffeescript
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    assert File.exist?(File.join(@folder, "coffeescripts", "app.coffee"))
  end
  
  def test_does_not_creates_coffeescript_folder_without_coffeescript
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "coffeescripts"))
  end
  
  
  def test_should_create_guardfile_with_coffeescript
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "coffeescript"')
  end

  
  def test_need_guardfile_with_coffee
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    assert p.needs_guardfile?
  end
end