require 'net/http'
require 'uri'
require 'json'
require "google/cloud/translate"

def translate_v2(q)
  url = URI.parse('https://translation.googleapis.com/language/translate/v2')
  params = {
    q: q,
    target: "ja",
    source: "en",
    key: ENV['GOOGLE_CLOUD_API_KEY']
  }
  url.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(url)
  JSON.parse(res.body)["data"]["translations"].first["translatedText"]
end

ARGV.each do |arg|
  puts translate_v2(arg)
end
