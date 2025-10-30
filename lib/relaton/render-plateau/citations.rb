module Relaton
  module Render
    class Citations
      def renderer(cite)
        #require 'debug'; binding.b
        @renderer[cite.dig(:data_liquid, :language)&.to_sym || @lang.to_sym]
      end
    end
  end
end
