module Relaton
  module Render
    class Citations
      def renderer(cite)
        #require "debug"; binding.b
        @renderer[cite[:language]&.to_sym || @lang.to_sym]
      end
    end
  end
end
