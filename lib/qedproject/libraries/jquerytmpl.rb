module QEDProject
  module Libraries
    class JQuerytmpl < QEDProject::Libraries::Base
      library :jquerytmpl
      depends_on [:jquery]
      set_js_files ["jquery.tmpl.min.js"]
    end
  end
end

