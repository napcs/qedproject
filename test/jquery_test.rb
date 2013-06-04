require 'project_test_helper'

class JqueryTest < ProjectTestCase
  
  def test_loads_jqery_into_index_page_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquery])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::JQuery.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
  def test_loads_jqery_into_asset_file_when_jammit_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquery], :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
    QEDProject::Libraries::JQuery.js_files.each do |js|
      assert source.include?("- javascripts/#{js}")
    end
  end
  
  def test_should_add_jquery_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquery])
    p.generate
    QEDProject::Libraries::JQuery.js_files.each do |js|
      assert File.exist?(File.join(@folder, "public", "javascripts", js))
    end
  end
end
