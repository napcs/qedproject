require 'project_test_helper'

class ProjectTest < ProjectTestCase
  
  def test_creates_project_skeleton
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(@folder)
  end

  def test_creates_gemfile
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "Gemfile"))
  end

  def test_should_add_guard_and_listen_to_gemfile
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    file = Pathname.new(File.join(@folder, "Gemfile"))
    assert file.read.include?("gem 'listen', '#{QEDProject::DEPENDENCIES[:listen]}'")
    assert file.read.include?("gem 'guard', '#{QEDProject::DEPENDENCIES[:guard]}'")
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

      
  def test_gets_array_of_js_files_for_libs
    p = QEDProject::Project.new(@folder, :libs => [:backbone, :jquery])
    assert p.js_assets.include?("backbone.js")
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
    p = QEDProject::Project.new(@folder, :libs => [:ember], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.10.1.min.js")
    assert p.js_assets[1].include?("ember")
  end
  
  def test_js_assets_has_jquery_first_and_only_includes_it_once_when_explicitly_requested_second
    p = QEDProject::Project.new(@folder, :libs => [:ember, :jquery], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.10.1.min.js")
    assert p.js_assets[1].include?("ember")
    # p.js_assets[2] is filled cos ember uses handlebars
    assert_nil p.js_assets[3]
    
  end
  
  def test_js_assets_has_jquery_first_and_only_includes_it_once_when_explicitly_requested_first
    p = QEDProject::Project.new(@folder, :libs => [:jquery, :ember], :jammit => true)
    assert p.js_assets[0].include?("jquery-1.10.1.min.js")
    assert p.js_assets[1].include?("ember")
    # p.js_assets[2] is filled cos ember uses handlebars
    assert_nil p.js_assets[3]
  end
  
  def test_does_not_run_bundler_by_default
    p = QEDProject::Project.new(@folder)
    p.expects(:bundle).never
    p.generate
  end
  
  def test_runs_bundler_when_option_passed
    p = QEDProject::Project.new(@folder, :bundle => true)
    p.expects(:bundle)
    p.generate
  end
  
end
