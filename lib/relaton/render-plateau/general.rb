require "relaton-render"
require "metanorma-jis"

module Relaton
  module Render
    module Plateau
      class General < ::Relaton::Render::Jis::General
        def initialize(opt = {})
          super
          @jis = ::Relaton::Render::Jis::General
            .new(language: @lang, script: @script, i18nhash: @i18n.get)
        end

        #def config_loc
          #YAML.load_file(File.join(File.dirname(__FILE__), "config.yml"))
        #end
      end
    end
  end
end
