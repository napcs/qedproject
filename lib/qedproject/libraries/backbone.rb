module QEDProject
  module Libraries
    class Backbone < QEDProject::Libraries::Base
      library :backbone
      set_js_files  ["json2.js", "underscore.js", "backbone.js"]
    end
  end
end

