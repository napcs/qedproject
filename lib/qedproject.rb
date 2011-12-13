require "qedproject/version"
require "qedproject/helpers"
require "qedproject/libraries/base"
require "qedproject/libraries/jquery"
require "qedproject/libraries/backbone"
require "qedproject/libraries/knockout"
require "qedproject/libraries/jquerytmpl"
require "qedproject/libraries/jquerymobile"
require "qedproject/libraries/skeleton"
require "qedproject/libraries/mustache"
require "qedproject/libraries/ember"

require "qedproject/project"
require "qedproject/plugins"

module QEDProject
  class BadLibraryError < RuntimeError
  end
end

QEDProject::Plugins::load_plugins
