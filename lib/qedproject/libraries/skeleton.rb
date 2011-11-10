module QEDProject
  module Libraries
    class Skeleton < QEDProject::Libraries::Base
      library :skeleton
      depends_on [:jquery]
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
        return true if self.project.skip_index
        index_file = File.join(self.project.path, self.project.public_dir, "index.html")
        FileUtils.rm_rf index_file if File.exist?(index_file)
        render_template "index.html", index_file
      end

    end
  end
end
