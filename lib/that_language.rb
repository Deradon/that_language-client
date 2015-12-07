require 'that_language/client'

module ThatLanguage
  def self.language(text)
    ThatLanguage::Client::LanguageQuery.new(text: text).language
  end

  def self.language_code(text)
    ThatLanguage::Client::LanguageCodeQuery.new(text: text).language_code
  end

  def self.monkeypatch(klass)
    klass.class_eval do
      define_method(:language_code) { ThatLanguage.language_code(self.to_s) }
    end
  end
end
