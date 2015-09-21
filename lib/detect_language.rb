require 'detect_language/client'

module DetectLanguage
  def self.locale(text)
    DetectLanguage::Client::LocaleQuery.new(text: text).locale
  end

  def self.monkeypatch(klass)
    klass.class_eval do
      define_method(:locale) { DetectLanguage.locale(self.to_s) }
    end
  end
end
