require 'project_test_helper'

class JquerymobileTest < ProjectTestCase
  
  def test_adds_index_page
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile])
    p.generate
    assert File.exist?(File.join(@folder, "public", "index-mobile.html"))
  end
  
  def test_uses_assets_path_for_css_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index-mobile.html")).
           read.include?('href="assets/app.css"')
  end
  
  def test_uses_assets_path_for_js_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index-mobile.html")).
           read.include?('src="assets/app.js"')
  end
  
  def test_loads_backbone_if_not_using_jammit_if_backbone_is_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile, :backbone])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index-mobile.html")).read
    QEDProject::Libraries::Backbone.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end

  def test_loads_jqery_into_index_page_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index-mobile.html")).read
    QEDProject::Libraries::JQuery.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
  def test_loads_jquery_into_asset_file_when_jammit_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquerymobile], :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
    QEDProject::Libraries::JQuery.js_files.each do |js|
      assert source.include?("- javascripts/#{js}")
    end
  end
  
  
end
