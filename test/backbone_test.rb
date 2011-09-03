require 'project_test_helper'

class BackboneTest < ProjectTestCase
  
  def test_loads_backbone_into_index_page_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:backbone])
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    QEDProject::Libraries::Backbone.js_files.each do |js|
      assert source.include?("src=\"javascripts/#{js}\"")
    end
  end
  
end