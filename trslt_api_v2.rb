require 'net/http'
require 'uri'
require 'json'
require 'optparse'

def translate(contents, source, target)
  url = URI.parse('https://translation.googleapis.com/language/translate/v2')
  params = {
    q: contents,
    source: source,
    target: target,
    key: ENV['GOOGLE_CLOUD_API_KEY']
  }
  url.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(url)
  JSON.parse(res.body)['data']['translations'].first['translatedText']
end

if ARGV.empty?
  puts 'Please set parameters.'
  exit
end

source = 'en'.freeze
target = 'ja'.freeze

opt = OptionParser.new
opt.on('-s', '--source [ISO-639-1 Code]', 'source language') { |val| source = val }
opt.on('-t', '--target [ISO-639-1 Code]', 'target language') { |val| target = val }
opt.parse!(ARGV)

ARGV.each do |arg|
  puts translate(arg, source, target)
end
