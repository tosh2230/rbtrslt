require 'net/http'
require 'uri'
require 'json'

SOURCE = 'ja'.freeze
TARGET = 'en'.freeze

def translate(contents)
  url = URI.parse('https://translation.googleapis.com/language/translate/v2')
  params = {
    q: contents,
    source: SOURCE,
    target: TARGET,
    key: ENV['GOOGLE_CLOUD_API_KEY']
  }
  url.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(url)
  JSON.parse(res.body)['data']['translations'].first['translatedText']
end

if ARGV.empty?
  puts 'Please set paramenters.'
else
  ARGV.each do |arg|
    puts translate(arg)
  end
end
