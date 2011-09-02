require 'rubygems'
require 'test/unit'
require 'lib/qedproject'


class ProjectTest < Test::Unit::TestCase 

  require 'pathname'

  def setup
    @folder = "tmpproject"
  end
  
  def teardown
    FileUtils.rm_rf @folder
  end
  
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
    assert File.exist?(File.join(@folder, "public", "javascripts","jquery-1.6.2.min.js"))
  end
    
  def test_should_create_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "sass"')
  end
  
  def test_creates_sass_folder_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    p.generate
    assert File.exist?(File.join(@folder, "sass"))
  end
  
  def test_does_not_creates_sass_folder_withoout_sass
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "sass"))
  end
  
  def test_creates_coffeescript_folder_with_coffeescript
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    assert File.exist?(File.join(@folder, "coffeescripts"))
  end
  
  def test_does_not_creates_coffeescript_folder_without_coffeescript
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "coffeescripts"))
  end
  
  
  def test_should_create_guardfile_with_coffeescript
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "coffeescript"')
  end

 

  def test_need_guardfile_with_sass
    p = QEDProject::Project.new(@folder, :sass => true)
    assert p.needs_guardfile?
  end
  
  def test_need_guardfile_with_coffee
    p = QEDProject::Project.new(@folder, :coffeescript => true)
    assert p.needs_guardfile?
  end  

  def test_no_tests_when_not_specified
    p = QEDProject::Project.new(@folder)
    p.generate
      assert !File.exist?(File.join(@folder, "spec"))
  end
  
  def test_includes_test_folder_skeleton_when_specified
    p = QEDProject::Project.new(@folder, :testing => true)
    p.generate
    assert File.exist? File.join(@folder, "spec")
    assert File.exist? File.join(@folder, "spec", "lib")
    assert File.exist? File.join(@folder, "spec", "suite.html")
  end
  
  def test_includes_js_test_when_testing_without_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true)
    p.generate
    assert File.exist? File.join(@folder, "spec", "sampleSpec.js")
  end
  
  def test_includes_coffeescript_test_when_testing_with_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true, :coffeescript => true)
    p.generate
    assert File.exist? File.join(@folder, "spec", "sampleSpec.coffee")
  end
  
  def test_guardfile_includes_watch_on_spec_folder_when_testing_with_coffeescript
    p = QEDProject::Project.new(@folder, :testing => true, :coffeescript => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "coffeescript", :input => "spec", :output => "spec"')
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
  
  def test_adds_rakefile
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "index.html"))
  end  

  def test_handles_bogus_libraries
    p = QEDProject::Project.new(@folder, :libs => [:backbone, :zzz])
    assert p.js_assets.include?("backbone-min.js")
  end

end
