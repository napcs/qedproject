require 'project_test_helper'

class SkeletonTest < ProjectTestCase
  
  def test_adds_index_page
    p = QEDProject::Project.new(@folder, :libs => [:skeleton])
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
  end
  
  def test_uses_assets_path_for_css_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:skeleton], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index.html")).
           read.include?('href="assets/app.css"')
  end
  
  def test_uses_assets_path_for_js_on_index_path_with_jammit
    p = QEDProject::Project.new(@folder, :libs => [:skeleton], :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "public", "index.html")).
           read.include?('src="assets/app.js"')
  end
  
  def test_uses_css_path_if_not_using_jammit
    p = QEDProject::Project.new(@folder, :libs => [:skeleton])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Skeleton.css_files.each do |css|
      assert source.include?("href=\"stylesheets/#{css}\"")
    end
  end
  
  def test_uses_js_path_if_not_using_jammit
    p = QEDProject::Project.new(@folder, :libs => [:skeleton, :backbone])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Skeleton.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
  def test_loads_backbone_if_not_using_jammit_if_backbone_is_specified
    p = QEDProject::Project.new(@folder, :libs => [:skeleton, :backbone])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Backbone.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
  
end