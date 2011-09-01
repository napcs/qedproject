module QEDProject
  module Helpers
    # Reads a template from the file system,
    # evaluates it with ERB
    # places it in the output folder specified.
    # Takes the binding context as the last parameter
    # so that ERb has access to instance variables, etc.
    # This works similar to how Rails and Sinatra templates
    # work.
    def render_template_to_file(template, file, context)
      t = File.read(File.join(self.template_root, template))
      File.open(file, "w") do |f|
        f << ERB.new(t, nil, "-").result(context)
      end
    end
  end
end