require 'project_test_helper'

class ProjectTest < ProjectTestCase
  
  def test_creates_project_skeleton
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(@folder)
  end

  def test_creates_public_folder
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public"))
  end
  
  def test_creates_public_folder_with_specified_name
    p = QEDProject::Project.new(@folder, :public_dir => "site")
    p.generate
    assert !File.exist?(File.join(@folder, "public"))
    
    assert File.exist?(File.join(@folder, "site"))
  end
  
  def test_creates_images_folder
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "images"))
  end

  def test_should_not_create_guardfile_without_sass_jammit_or_coffeescript
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "Guardfile"))
  end

  def test_should_add_jquery_when_specified
    p = QEDProject::Project.new(@folder, :libs => [:jquery])
    p.generate
    assert File.exist?(File.join(@folder, "public", "javascripts","jquery-1.6.4.min.js"))
  end
      
  def test_gets_array_of_js_files_for_libs
    p = QEDProject::Project.new(@folder, :libs => [:backbone, :jquery])
    assert p.js_assets.include?("backbone-min.js")
  end
  
  def test_adds_index_page
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
  end
  
  def test_keeps_original_index_page_if_one_exists
    FileUtils.mkdir_p(File.join(@folder, "public"))
    File.open(File.join(@folder, "public", "index.html"), "w") do |f|
      f << "Hello world from my test"
    end
    
    p = QEDProject::Project.new(@folder, :no_overwrite => true)
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    assert source.include?("Hello world from my test")
  end
  
  def test_adds_js_file
    p = QEDProject::Project.new(@folder)  
    p.generate
    assert File.exist?(File.join(@folder, "public","javascripts", "app.js"))
  end
  
  def test_adds_css_file
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public","stylesheets", "app.css"))
  end
  
  def test_adds_js_file_to_index
    p = QEDProject::Project.new(@folder)
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    assert source.include?("src=\"javascripts/app.js\"")
  end
  
  def test_adds_css_file_to_index
    p = QEDProject::Project.new(@folder)
    p.generate
    source = Pathname.new(File.join(@folder, "public", "index.html")).read
    assert source.include?("href=\"stylesheets/app.css\"")
  end
  
  
  
  def test_skips_adding_index_page_if_skipped
    p = QEDProject::Project.new(@folder, :skip_index => true)
    p.generate
    assert !File.exist?(File.join(@folder, "public", "index.html"))
  end
  
  def test_adds_rakefile
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
  end  

  def test_handles_bogus_libraries
    assert_raise(QEDProject::BadLibraryError) { 
      p = QEDProject::Project.new(@folder, :libs => [:backbone, :zzz])
    }
  end

  def test_js_assets_has_jquery_first
    p = QEDProject::Project.new(@folder, :libs => [:jquerytmpl], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.6.4.min.js")
    assert p.js_assets[1].include?("jquery.tmpl.min.js")
  end
  
  def test_js_assets_has_jquery_first_and_only_includes_it_once_when_explicitly_requested_second
    p = QEDProject::Project.new(@folder, :libs => [:jquerytmpl, :jquery], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.6.4.min.js")
    assert p.js_assets[1].include?("jquery.tmpl.min.js")
    assert_nil p.js_assets[2]
    
  end
  
  def test_js_assets_has_jquery_first_and_only_includes_it_once_when_explicitly_requested_first
    p = QEDProject::Project.new(@folder, :libs => [:jquery, :jquerytmpl], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.6.4.min.js")
    assert p.js_assets[1].include?("jquery.tmpl.min.js")
    assert_nil p.js_assets[2]
  end
end
