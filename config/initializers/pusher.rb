require 'pusher'

Pusher.app_id = "612262"
Pusher.key = "55d77172c59cfedfe8f9"
Pusher.secret = ENV["PUSHER_APP_SECRET"]
Pusher.cluster = "us2"
Pusher.logger = Rails.logger
Pusher.encrypted = true
