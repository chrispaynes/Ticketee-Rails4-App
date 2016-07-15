# stores all uploaded files outside public folder
CarrierWave.configure do |config|
  config.root = Rails.root
end
