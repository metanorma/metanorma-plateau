module Relaton
  module Render
    module Plateau
      class I18n < ::Relaton::Render::I18n
        def initialize(opt)
          super
          #require "debug"; binding.b
          @lang = opt["language"]
        end

        def select_default
          @i18n[@lang]
        end

        def select_obj(obj)
          @i18n[obj[:language]]
        end
      end
    end
  end
end
