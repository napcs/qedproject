module QEDProject
  module Libraries
    class Jquerymobile < QEDProject::Libraries::Base
      library :jquerymobile
      depends_on [:jquery]
      set_js_files ["jquery.mobile-1.0.js"]
      set_css_files ["jquery.mobile-1.0.css" ] 
      set_image_files [
        "ajax-loader.png",
        "icons-18-black.png",
        "icons-18-white.png",
        "icons-36-black.png",
        "icons-36-white.png"
      ]

      def generate!
        super         
        file = File.join(self.project.path, self.project.public_dir, "index-mobile.html")
        render_template "index.html", file
      end

    end
  end
end
