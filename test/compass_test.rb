require 'project_test_helper'

class CompassTest < ProjectTestCase
  
  def test_adds_sass_too
    p = QEDProject::Project.new(@folder, :compass => true)
    assert p.sass
  end
  
  def test_needs_config_folder
    p = QEDProject::Project.new(@folder, :compass => true)
    assert p.needs_config_folder?
  end
  
  
  def test_adds_compass_config
    p = QEDProject::Project.new(@folder, :compass => true)
    p.generate
    assert File.exist?(File.join(@folder, "config", "compass.rb"))
  end
  
  def test_uses_tmp_folder_with_jammit
    p = QEDProject::Project.new(@folder, :compass => true, :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "compass.rb")).read
    assert source.include?('css_dir = "tmp"')
  end
  
  def test_uses_public_stylesheets_folder_with_no_jammit
    p = QEDProject::Project.new(@folder, :compass => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "compass.rb")).read
    assert source.include?('css_dir = "public/stylesheets"')
  end

  def test_should_create_guardfile_with_compass
    p = QEDProject::Project.new(@folder, :compass => true)
    p.generate
    
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "compass"')
  end
  
  def test_should_not_create_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :compass => true)
    p.generate
    assert !(Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "sass"'))
  end
  
end