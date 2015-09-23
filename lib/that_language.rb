require 'that_language/client'

module ThatLanguage
  def self.locale(text)
    ThatLanguage::Client::LocaleQuery.new(text: text).locale
  end

  def self.monkeypatch(klass)
    klass.class_eval do
      define_method(:locale) { ThatLanguage.locale(self.to_s) }
    end
  end
end
