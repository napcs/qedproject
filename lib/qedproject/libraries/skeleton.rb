module QEDProject
  module Libraries
    class Skeleton < QEDProject::Libraries::Base
      library :skeleton
      set_js_files ["tabs.js"]
      set_css_files ["base.css", "skeleton.css", "layout.css" ] 
      set_image_files [
        "apple-touch-icon-114x114.png",
        "apple-touch-icon-72x72.png",
        "apple-touch-icon.png",
        "favicon.ico"
      ]

      def generate!
        super
        index_file = File.join(self.project.path, "public", "index.html")
        FileUtils.rm_rf index_file if File.exist?(index_file)
        render_template_to_file "index.html", index_file, binding
      end

    end
  end
end
