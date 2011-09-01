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
        render_template_to_file "index.html", File.join(self.project.path, "public", "index.html"), binding
      end

    end
  end
end
