module QEDProject
  module Libraries
    class Angular < QEDProject::Libraries::Base
      library :angular
      set_js_files ["angular-1.1.5.js", "angular-resource.js"]
    end
  end
end
