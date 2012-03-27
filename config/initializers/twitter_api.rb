file_handle= File.read(::Rails.root.to_s+"/twitter_credentials.json")
credentials = JSON.parse(file_handle)

Twitter.configure do |config|
  config.consumer_key = credentials["consumer_key"]
  config.consumer_secret = credentials["consumer_secret"]
  config.oauth_token = credentials["access_token"]
  config.oauth_token_secret = credentials["token_secret"]
end