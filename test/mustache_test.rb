require 'project_test_helper'

class MustacheTest < ProjectTestCase
  
  def test_loads_mustache_into_index_page_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:mustache])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Mustache.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
  def test_loads_mustache_into_asset_file_when_jammit_specified
    p = QEDProject::Project.new(@folder, :libs => [:mustache], :jammit => true)
    p.generate
    source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
    QEDProject::Libraries::Mustache.js_files.each do |js|
      assert source.include?("- javascripts/#{js}")
    end
  end
    
end