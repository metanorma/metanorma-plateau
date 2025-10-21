module Metanorma
  module Plateau
    class Converter
      PLATEAU_LOG_MESSAGES = {
        # rubocop:disable Naming/VariableNumber
        "PLATEAU_1": { category: "Document Attributes",
                       error: "%s is not a recognised document type",
                       severity: 2 },
      }.freeze
      # rubocop:enable Naming/VariableNumber

      def log_messages
        super.merge(PLATEAU_LOG_MESSAGES)
      end
    end
  end
end
