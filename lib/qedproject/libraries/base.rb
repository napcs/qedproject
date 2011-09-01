module QEDProject
  module Libraries
      
    class Base
      include QEDProject::Helpers
      
      attr_accessor :template_root, :lib_root, :project
      class << self
            
        attr_accessor :libs

        # Support for DSL, for setting the library name
        # when creating the adapter.
        # Adds the library and class to QEDProject::Libraries::Base.libs hash
        # and also creates a getter method on the adapter instance
        def library(name)
          QEDProject::Libraries::Base.libs ||= {}
          QEDProject::Libraries::Base.libs[name] = self
          class_eval do
            define_method :library do
              name
            end
          end
        end 
        
        def set_js_files(files)
          # define class method
          m = class << self; self; end
          m.send :define_method, :js_files do
            files
          end
          
          # define instance method
          class_eval do
            define_method :js_files do
              files
            end
          end
        end
        
        # convenience method for the DSL for setting CSS files
        def set_css_files(files)
          # define class method to get the data out
           m = class << self; self; end
           m.send :define_method, :css_files do
             files
           end
          
          class_eval do
            define_method :css_files do
              files
            end
          end
        end
        

        # convenience method for the DSL for setting image files.
        def set_image_files(files)

          m = class << self; self; end
          m.send :define_method, :image_files do
            files
          end
          
          class_eval do
            define_method :image_files do
              files
            end
          end
        end
      end

      def initialize(project) 
        @project = project
        @lib_root = File.join(@project.vendor_root, self.library.to_s)
        @template_root = File.join(@lib_root, "templates")
      end
      
      def generate!
        self.copy_js     if self.respond_to?(:js_files) && self.js_files.any?
        self.copy_css    if self.respond_to?(:css_files) && self.css_files.any?
        self.copy_images if self.respond_to?(:image_files) && self.image_files.any?
      end
      
      def copy_images
        self.image_files.each do |lib|
          ::FileUtils.cp_r File.join(self.lib_root, lib), File.join(self.project.path, self.project.images_path), :verbose => self.project.verbose
        end
      end
      
      def copy_css
        self.css_files.each do |lib|
          ::FileUtils.cp_r File.join(self.lib_root, lib), File.join(self.project.path, self.project.css_path), :verbose => self.project.verbose
        end
      end

      def copy_js
        self.js_files.each do |lib|
          ::FileUtils.cp_r File.join(self.lib_root, lib), File.join(self.project.path, self.project.js_path), :verbose => self.project.verbose
        end
      end

    end
  end
end
