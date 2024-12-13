require "japanese_calendar"
require "twitter_cldr"

module IsoDoc
  module Plateau
    class I18n < IsoDoc::Jis::I18n
      def load_file(fname)
        f = File.join(File.dirname(__FILE__), fname)
        File.exist?(f) ? YAML.load_file(f) : {}
      end

      def load_yaml1(lang, script)
        y = load_file("i18n-#{yaml_lang(lang, script)}.yaml")
        y.empty? ? load_file("i18n-en.yaml").merge(super) : super.deep_merge(y)
      end

      # Numeric regnal year
      def japanese_year(time)
        era_yr = time.era_year.to_i
        "#{time.strftime('%JN')}#{era_yr}年"
      rescue StandardError
        time.year.to_s
      end
    end
  end
end

