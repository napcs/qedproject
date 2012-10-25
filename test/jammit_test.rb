require 'project_test_helper'


class JammitTest < ProjectTestCase

  require 'pathname'
  
  def test_should_create_guardfile_with_jammit
    p = QEDProject::Project.new(@folder, :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "Guardfile")).read.include?('guard "jammit"')
  end
  
  def test_uses_public_folder_for_js_when_no_jammit
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "javascripts"))
  end
  
  def test_does_not_use_public_folder_for_js_when_jammit
    p = QEDProject::Project.new(@folder, :jammit => true)
    p.generate
    assert File.exist?(File.join(@folder, "javascripts"))
  end
  
  def test_uses_public_folder_for_css_when_no_jammit
    p = QEDProject::Project.new(@folder)
    p.generate
    assert File.exist?(File.join(@folder, "public", "stylesheets"))
  end
  
  def test_does_not_use_public_folder_for_css_when_jammit
    p = QEDProject::Project.new(@folder, :jammit => true)
    p.generate
    assert File.exist?(File.join(@folder, "stylesheets"))
  end
  
  
  def test_does_not_create_config_folder_without_jammit
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "config"))
  end
  
  def test_creates_asset_file_when_jammit
    p = QEDProject::Project.new(@folder, :jammit => true)
    p.generate
    assert Pathname.new(File.join(@folder, "config/assets.yml")).read.include?('stylesheets:')
  end
  
  def test_does_not_create_asset_file_when_no_jammit
    p = QEDProject::Project.new(@folder)
    p.generate
    assert !File.exist?(File.join(@folder, "config", "assets.yml"))
  end
  
  def test_puts_coffeescript_in_js_folder_without_jammit
     text = 'guard "coffeescript", :input => "coffeescripts", :output => "public/javascripts"'
     p = QEDProject::Project.new(@folder, :coffeescript => true)
     p.generate
     source = Pathname.new(File.join(@folder, "Guardfile")).read
     assert source.include?(text)  
   end  
  
   def test_puts_coffeescript_in_tmp_folder_with_jammit
     text = 'guard "coffeescript", :input => "coffeescripts", :output => "_qedtmp"'
     p = QEDProject::Project.new(@folder, :coffeescript => true, :jammit => true)
     p.generate
     source = Pathname.new(File.join(@folder, "Guardfile")).read
     assert source.include?(text)
   end
  
   def test_puts_sass_in_css_folder_without_jammit
     text = 'guard "sass", :input => "sass", :output => "public/stylesheets"'
     p = QEDProject::Project.new(@folder, :sass => true)
     p.generate
     source = Pathname.new(File.join(@folder, "Guardfile")).read
     assert source.include?(text)  
   end  
  
   def test_puts_sass_in_tmp_folder_with_jammit
     text = 'guard "sass", :input => "sass", :output => "_qedtmp"'
     p = QEDProject::Project.new(@folder, :sass => true, :jammit => true)
     p.generate
  
     source = Pathname.new(File.join(@folder, "Guardfile")).read
     assert source.include?(text)
   end
   
   def test_need_guardfile_with_jammit
     p = QEDProject::Project.new(@folder, :jammit => true)
     assert p.needs_guardfile?
   end
  
   def test_uses_assets_path_for_css_on_index_path_with_jammit
      p = QEDProject::Project.new(@folder, :jammit => true)
      p.generate
      assert Pathname.new(File.join(@folder, "public", "index.html")).
             read.include?('href="assets/app.css"')
    end
  
    def test_uses_assets_path_for_js_on_index_file_with_jammit
      p = QEDProject::Project.new(@folder, :jammit => true)
      p.generate
      assert Pathname.new(File.join(@folder, "public", "index.html")).
             read.include?('src="assets/app.js"')
    end
    
    def test_no_guard_task_with_no_jammit
      p = QEDProject::Project.new(@folder)
      p.generate
      source = Pathname.new(File.join(@folder, "Rakefile")).read
      assert !source.include?("task :compile")
      assert !source.include?("task :deploy => :compile")
      assert source.include?("task :deploy")
    end
    
    def test_adds_jquery_to_asset_package
      p = QEDProject::Project.new(@folder, :jammit => true, :libs => [:jquery])
      p.generate
      source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
      assert source.include?("javascripts/jquery-1.8.2.min.js")
    end
    
    def test_adds_app_js_to_javascripts_folder_in_asset_file_when_no_coffeescript
      p = QEDProject::Project.new(@folder, :jammit => true)
      p.generate
      source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
      assert source.include?("javascripts/app.js")
    end
    
    def test_adds_app_css_to_stylesheets_folder_in_asset_file_when_no_sass
      p = QEDProject::Project.new(@folder, :jammit => true)
      p.generate
      source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
      assert source.include?("stylesheets/app.css")
    end
    
    def test_adds_app_js_to_tmp_folder_in_asset_file_when_coffeescript
      p = QEDProject::Project.new(@folder, :jammit => true, :coffeescript => true)
      p.generate
      source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
      assert source.include?("_qedtmp/app.js")
    end
    
    def test_adds_app_css_to_tmp_folder_in_asset_file_when_sass
      p = QEDProject::Project.new(@folder, :jammit => true, :sass => true)
      p.generate
      source = Pathname.new(File.join(@folder, "config", "assets.yml")).read
      assert source.include?("_qedtmp/app.css")
    end
    
    
    def test_should_create_gemfile_with_jammit
      p = QEDProject::Project.new(@folder, :jammit => true)
      p.generate
      assert Pathname.new(File.join(@folder, "Gemfile")).read.include?("gem 'guard-jammit'")
    end
    
    
end
