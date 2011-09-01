module QEDProject
  module Libraries
    class Backbone < QEDProject::Libraries::Base
      library :backbone
      set_js_files  ["json2.js", "underscore-min.js", "backbone-min.js"]
    end
  end
end

