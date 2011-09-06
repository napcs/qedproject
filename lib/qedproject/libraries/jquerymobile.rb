module QEDProject
  module Libraries
    class Jquerymobile < QEDProject::Libraries::Base
      library :jquerymobile
      depends_on [:jquery]
      set_js_files ["jquery.mobile-1.0b2.js"]
      set_css_files ["jquery.mobile-1.0b2.css" ] 
      set_image_files [
        "ajax-loader.png",
        "icons-18-black.png",
        "icons-18-white.png",
        "icons-36-black.png",
        "icons-36-white.png",
        "icon-search-black.png"
      ]

      def generate!
        super                                                                                     
        render_template_to_file "index.html", File.join(self.project.path, "public", "index-mobile.html"), binding
      end

    end
  end
end
