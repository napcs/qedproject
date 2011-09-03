module QEDProject
  module Plugins
    
    def self.load_plugins
      Gem.refresh
      (Gem::Specification.respond_to?(:each) ? Gem::Specification : Gem.source_index.find_name('')).each do |gem|
        next if gem.name !~ /^qedproject-/
        require gem.name
      end
    end
  end
end