require 'project_test_helper'

class KnockoutTest < ProjectTestCase
  
  def test_adds_index_page
    p = QEDProject::Project.new(@folder, :libs => [:angular])
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
  end
  
  def test_uses_assets_path_for_css_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:knockout], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index.html")).
           read.include?('href="assets/app.css"')
  end
  
  def test_uses_assets_path_for_js_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:knockout], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index.html")).
           read.include?('src="assets/app.js"')
  end
  
  def test_loads_knockout_if_not_using_jammit_if_knockout_is_specified
    p = QEDProject::Project.new(@folder, :libs => [:knockout])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Knockout.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end

  def test_loads_knockout_js_files_into_page
    p = QEDProject::Project.new(@folder, :libs => [:knockout ])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Knockout.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end

  def test_loads_knockout_into_asset_file_when_jammit_specified
    p = QEDProject::Project.new(@folder, :libs => [:knockout], :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
    QEDProject::Libraries::Knockout.js_files.each do |js|
      assert source.include?("- javascripts/#{js}")
    end
  end

  
    
end
