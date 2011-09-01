require 'fileutils'
require 'erb'
module QEDProject
  
  class Project
    
    include QEDProject::Helpers
    
    attr_accessor :path, :libs, :coffeescript, :sass, :jammit,
                  :js_path, :css_path, :images_path, :verbose, :testing
    # convenience method to create a new project.
    # Simply call create with the project path and the options.
    def self.create(project_path, options= {})
       self.new(project_path, options).generate
    end
    
    def template_root
      File.expand_path("../../../templates", __FILE__)
    end
    
    def vendor_root
      File.expand_path("../../../vendor", __FILE__)
    end
    
    # Creates a new Project instance.
    # Options:
    #    :libs : A list of js libraries to include, Can be :backbone, :jquery, :knockout
    #    :jammit: boolean, should Jammit be included?
    #    :coffeescript : Should CoffeeScript support be included?
    #    :sass           Should sass support be included?
    def initialize(project_path, options = {})
      self.path = project_path
      self.process_options(options)
      self.set_paths
    end
       
       
    # Convenience method for showing all of the JavaScript files that 
    # the project should contain. Good for creating asset lists
    # and loading files in rendered templates                                    
    def js_assets
      if libs
        libs.inject([]) do |original, lib|
           original += QEDProject::Libraries::Base.libs[lib].js_files if QEDProject::Libraries::Base.libs[lib].respond_to?(:js_files)
        end 
      else
        []
      end
    end
    
    # Convenience method for showing all of the css files that 
    # the project should contain. Good for creating asset lists
    # and loading files in rendered templates
    def css_assets
      if libs
        libs.inject([]) do |original, lib|
          original += QEDProject::Libraries::Base.libs[lib].css_files if QEDProject::Libraries::Base.libs[lib].respond_to?(:css_files)
        end
      else
        []
      end
    end                                     

    # Sets instance methods with values from the options hash.
    def process_options(options)
      self.libs = options[:libs]
      self.jammit = options[:jammit]
      self.sass = options[:sass]
      self.coffeescript = options[:coffeescript]
      self.verbose = options[:verbose]
      self.testing = options[:testing]
    end

    # Set up the basic paths we'll use throughout
    def set_paths
       self.images_path = File.join("public", "images")
       self.js_path = self.jammit ? "javascripts" : File.join("public", "javascripts")
       self.css_path = self.jammit ? "stylesheets" : File.join("public", "stylesheets")
    end

    # We need a guardfile if the user is using jammit, sass, or coffeescript.
    def needs_guardfile?
      self.jammit || self.sass || self.coffeescript
    end
    
    # Only jammit needs a config folder for now.
    def needs_config_folder?
      self.jammit
    end

    # Start the project generation.
    # Create the folder
    # Get all of the libraries
    # create an assets file if needed
    # add the testing folder if needed
    # create a guardfile if needed
    def generate
      self.create_project_skeleton
      self.create_index                             
      self.get_libraries if self.libs
      self.create_asset_file if self.jammit
      self.add_testing if self.testing
      self.create_guardfile if self.needs_guardfile?
      self.create_rakefile
    end

    # includes the Jasmine BDD framework for javascript testing
    def add_testing
      FileUtils.mkdir_p File.join(self.path, "spec"), :verbose => self.verbose
      FileUtils.cp_r File.join(self.vendor_root, "jasmine", "lib"), 
                     File.join(self.path, "spec", "lib"), :verbose => self.verbose
    

      render_template_to_file "suite.html", File.join(self.path, "spec", "suite.html"), binding
      if self.coffeescript
        render_template_to_file "sampleSpec.coffee", File.join(self.path, "spec", "sampleSpec.coffee"), binding
      else
        render_template_to_file "sampleSpec.js", File.join(self.path, "spec", "sampleSpec.js"), binding
      end

    end

    # Set up the main project skeleton
    # project
    #   public/
    #     assets/           * only with assets
    #     images/
    #     javascripts/      * only without assets
    #     stylesheets/      * only without assets
    #   config/
    #     assets.yml        * optional
    #   coffeescripts/      * optional
    #   sass/               * optional
    #   spec/               * optional
    #   Guardfile           * optional
    def create_project_skeleton
      ::FileUtils.mkdir_p( self.path, :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, "public"), :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, self.images_path), :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, "tmp"), :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, self.js_path), :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, self.css_path), :verbose => self.verbose)
      ::FileUtils.mkdir_p( File.join(self.path, "config"), :verbose => self.verbose) if self.needs_config_folder?
      ::FileUtils.mkdir_p( File.join(self.path, "coffeescripts"), :verbose => self.verbose) if self.coffeescript
      ::FileUtils.mkdir_p( File.join(self.path, "sass"), :verbose => self.verbose) if self.sass
    end

    # Loop through the libraries the user added
    # and run their generate methods
    # which pulls in the additional optional files.
    def get_libraries 
      libs.each do |lib|
         library = QEDProject::Libraries::Base.libs[lib]
         if library
           l = library.new(self)
           l.generate!
         else
           puts "Unsupported library - #{lib}"
         end
      end
    end

    def create_asset_file
      render_template_to_file("assets.yml", File.join(self.path, "config", "assets.yml"), binding)
      puts "Created #{File.join(self.path, 'config', 'assets.yml')}" if self.verbose
    end

    def create_guardfile
      render_template_to_file "Guardfile", File.join(self.path, "Guardfile"), binding
      puts "Created #{ File.join(self.path, "Guardfile")}" if self.verbose
    end
    
    def create_index
      @project = self
      render_template_to_file "index.html", File.join(self.path, "public", "index.html"), binding
      puts "Created #{ File.join(self.path, "public", "index.html")}" if self.verbose
    end
        
    def create_rakefile
      render_template_to_file "Rakefile", File.join(self.path, "Rakefile"), binding
      puts "Created #{ File.join(self.path, "Rakefile")}" if self.verbose
    end
  end
end
