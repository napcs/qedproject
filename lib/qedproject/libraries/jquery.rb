module QEDProject
  module Libraries
    class JQuery < QEDProject::Libraries::Base
      library :jquery
      set_js_files ["jquery-1.10.1.min.js"]
    end
  end
end

