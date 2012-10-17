require 'project_test_helper'

class LiveReloadTest < ProjectTestCase
  
  def test_guardfile_includes_livereload_watcher_for_index
    p = QEDProject::Project.new(@folder, :livereload => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert source.include?('watch(%r{public/.+\.(css|js|html)})')
  end
  
  def test_guardfile_includes_livereload_watcher_for_assets
    p = QEDProject::Project.new(@folder, :livereload => true, :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert source.include?('watch(%r{public/assets/.+\.(css|js|html)})')
  end
  
  def test_guardfile_includes_watch_on_spec_folder_for_livereload_when_testing
    p = QEDProject::Project.new(@folder, :testing => true, :livereload => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert source.include?('watch(%r{spec/.+\.(|js|html)})')
  end
  
  def test_guardfile_does_not_include_watch_on_spec_folder_for_livereload_when_not_invoked
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    source = Pathname.new(File.join(@folder, "Guardfile")).read
    assert !source.include?('livereload')
  end
  
end
