require 'rest-client'
require 'nokogiri'

class WikiController < ApplicationController
  def translate
    article = params[:article]
    url = "https://en.wikipedia.org/wiki/#{article}"
    response = RestClient.get(url)
    html = Nokogiri::HTML(response.body)
    article_text = html.css('div.mw-parser-output p').map(&:text).join(' ')
    pig_latin_text = to_pig_latin(article_text)
    render plain: pig_latin_text
  end

  private

  def to_pig_latin(string)
    vowels = %w[a e i o u]
    words = string.split(' ')
  
    pig_latin_words = words.map do |word|
      if vowels.include?(word[0].downcase)
        word + 'ay' # If word starts with a vowel, add 'ay' to the end
      else
        consonant_count = 0
        while consonant_count < word.length && !vowels.include?(word[consonant_count].downcase)
          consonant_count += 1
        end
        prefix = word[0...consonant_count]
        suffix = word[consonant_count..]
        suffix + prefix + 'ay' # Move consonant cluster to the end and add 'ay'
      end
    end
  
    pig_latin_words.join(' ')
  end
  
end
