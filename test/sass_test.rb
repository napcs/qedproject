require 'project_test_helper'
class SassTest < ProjectTestCase
  def test_should_create_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "sass"')
  end
  
  def test_creates_sass_folder_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert File.exist?(File.join(@folder, "sass"))
  end
  
  def test_does_not_creates_sass_folder_withoout_sass
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "sass"))
  end
  
end