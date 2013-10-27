require 'project_test_helper'
class SassTest < ProjectTestCase
  def test_need_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    assert p.needs_guardfile?
  end
  
  def test_should_create_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    file = Pathname.new(File.join(@folder, "Gemfile"))
    assert file.read.include?("gem 'sass', '#{QEDProject::DEPENDENCIES[:sass]}'")
    assert file.read.include?("gem 'guard-sass', '#{QEDProject::DEPENDENCIES[:guard_sass]}'")
  end
  
  def test_creates_sass_folder_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert File.exist?(File.join(@folder, "sass"))
  end
  
  def test_creates_sass_file_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert File.exist?(File.join(@folder, "sass", "app.sass"))
  end
  
  def test_does_not_creates_sass_folder_withoout_sass
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "sass"))
  end
  
  def test_should_create_gemfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Gemfile")).read.include?("gem 'guard-sass'")
  end
  
end
