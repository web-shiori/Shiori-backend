require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_credentials = {
    # Amazon S3用の設定
    provider: 'AWS',
    region: Rails.application.credentials.aws[:region],
    aws_access_key_id: Rails.application.credentials.aws[:aws_access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:aws_secret_access_key],
    path_style: true
  }
end
