# frozen_string_literal: true

require "lutaml/model"

module Metanorma
  module Plateau
    # plateau's lutaml-model register: type substitutions from standoc.
    # Formerly Metanorma::Registers::Setup.setup_plateau_register in metanorma-document.
    module Registers
      module_function

      def setup
          reg = Lutaml::Model::Register.new(:plateau_document,
                                            fallback: [:jis_document])
          Lutaml::Model::GlobalRegister.register(reg)
      end
    end
  end
end
