# frozen_string_literal: true

require 'English'
require 'pathname'
require 'fileutils'

def get_env_variable(key)
  ENV[key].nil? || ENV[key] == '' ? nil : ENV[key]
end

def file_size(path)
  format('%.2f', (File.size(path).to_f / 2**20))
end

def check_file_size(path, threshold, action)
  return unless File.exist?(path.to_s)

  puts "Checking #{path}"
  size = file_size(path).to_f
  if (threshold != 0) && (size > threshold)
    puts "File size: #{size} is bigger than thresold: #{threshold} MB"
    raise 'Failing the workflow' if action == 'fail'
  end
end

def ipa_path
  export_path = ENV['AC_EXPORT_DIR']
  Dir.glob("#{export_path}/*.ipa").first.to_s
end

source_path = get_env_variable('AC_ANALYZER_SOURCE_PATH')
threshold = get_env_variable('AC_ANALYZER_FILESIZE_THRESHOLD').to_f
action = get_env_variable('AC_ANALYZER_FILESIZE_ACTION')

if source_path.nil?
  puts 'Checking default artifacts'
  apk_path = get_env_variable('AC_APK_PATH')
  aab_path = get_env_variable('AC_AAB_PATH')
  check_file_size(apk_path, threshold, action)
  check_file_size(aab_path, threshold, action)
  check_file_size(ipa_path, threshold, action)
else
  puts 'Checking user supplied path'
  check_file_size(source_path, threshold, action)
end
