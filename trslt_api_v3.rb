require 'google/cloud/translate'

SOURCE = 'ja'.freeze
TARGET = 'en'.freeze

def translate_v3(contents)
  project_id = `gcloud config configurations list | grep True`.split[3].strip
  location_id = 'global'

  client = Google::Cloud::Translate.translation_service
  parent = client.location_path(project: project_id, location: location_id)
  client.translate_text(
    parent: parent, contents: contents,
    source_language_code: SOURCE, target_language_code: TARGET
  )
end

if ARGV.empty?
  puts 'Please set paramenters.'
else
  response = translate_v3(ARGV)
  response.translations.each do |translation|
    puts translation.translated_text
  end
end
