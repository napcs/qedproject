require "qedproject/version"
require "qedproject/helpers"
require "qedproject/libraries/base"
require "qedproject/libraries/jquery"
require "qedproject/libraries/backbone"
require "qedproject/libraries/knockout"
require "qedproject/libraries/jquerytmpl"
require "qedproject/libraries/skeleton"
require "qedproject/project"

module QEDProject
  class BadLibraryError < RuntimeError
  end
end
