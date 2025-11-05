module Relaton
  module Render
    module Plateau
      class Citations < ::Relaton::Render::Citations
        def renderer(cite)
          @renderer[cite.dig(:data, :language)&.to_sym || @lang.to_sym]
        end
      end
    end
  end
end
