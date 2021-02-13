require 'optparse'
require 'google/cloud/translate'

def translate(contents, source, target)
  project_id = `gcloud config configurations list | grep True`.split[3].strip
  location_id = 'global'

  client = Google::Cloud::Translate.translation_service
  parent = client.location_path(project: project_id, location: location_id)
  client.translate_text(
    parent: parent, contents: contents,
    source_language_code: source, target_language_code: target
  )
end

if ARGV.empty?
  puts 'Please set paramenters.'
  exit
end

source = 'en'.freeze
target = 'ja'.freeze

opt = OptionParser.new
opt.on('-s', '--source [ISO-639-1 Code]', 'source language') { |val| source = val }
opt.on('-t', '--target [ISO-639-1 Code]', 'target language') { |val| target = val }
opt.parse!(ARGV)

response = translate(ARGV, source, target)
response.translations.each do |translation|
  puts translation.translated_text
end
