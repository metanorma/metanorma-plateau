module Relaton
  module Render
    class Citations
      def renderer(cite)
        @renderer[cite.dig(:data, :language)&.to_sym || @lang.to_sym]
      end
    end
  end
end
