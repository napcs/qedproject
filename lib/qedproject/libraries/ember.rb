module QEDProject
  module Libraries
    class Ember < QEDProject::Libraries::Base
      library :ember
      depends_on [:jquery]
      set_js_files ["ember-1.0.0-rc.1.js", "handlebars-1.0.0-rc.3.js"]
    end
  end
end
