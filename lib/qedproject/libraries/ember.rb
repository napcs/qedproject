module QEDProject
  module Libraries
    class Ember < QEDProject::Libraries::Base
      library :ember
      depends_on [:jquery]
      set_js_files ["ember-0.9.js", "app.js"]
      set_css_files ["style.css" ] 
      set_image_files [
        "apple-touch-icon-114x114-precomposed.png",
        "apple-touch-icon-57x57-precomposed.png",
        "apple-touch-icon-72x72-precomposed.png",
        "apple-touch-icon-precomposed.png",
        "apple-touch-icon.png",
        "favicon.ico"
      ]

      def generate!
        super
        return true if self.project.skip_index
        index_file = File.join(self.project.path, self.project.public_dir, "index.html")
        FileUtils.rm_rf index_file if File.exist?(index_file)
        render_template "index.html", index_file
      end

    end
  end
end
