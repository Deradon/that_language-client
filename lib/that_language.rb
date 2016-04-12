require 'that_language/client'

module ThatLanguage
  def self.language(text)
    ThatLanguage::Client::LanguageQuery.new(text: text).language
  end

  def self.language_code(text)
    ThatLanguage::Client::LanguageCodeQuery.new(text: text).language_code
  end

  def self.detect(text)
    ThatLanguage::Client::DetectQuery.new(text: text)
  end

  def self.details(text)
    ThatLanguage::Client::DetailsQuery.new(text: text)
  end

  def self.available
    ThatLanguage::Client::AvailableQuery.new.available
  end

  def self.available_languages
    available.values
  end

  def self.available_language_codes
    available.keys
  end

  def self.monkeypatch(klass)
    klass.class_eval do
      define_method(:language_code) { ThatLanguage.language_code(self.to_s) }
    end
  end
end
