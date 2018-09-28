module ApplicationHelper
  # ENV["RIOT_API_KEY"]
  # ^[0-9\\p{L} _\\.]+$
  require 'securerandom'
  require 'open-uri'

  def generate_key
    "soloq#{SecureRandom.hex(4)}"
  end

  def get_summoner_id_name(summoner_name)
    return false if summoner_name.length > 16 || summoner_name.length < 1

    url_name = summoner_name.gsub(' ', '%20')

    url = open("https://br1.api.riotgames.com/lol/summoner/v3/summoners/by-name/#{url_name}?api_key=#{ENV["RIOT_KEY"]}").string

    summoner_hash = JSON.parse url
    [summoner_hash["id"], summoner_hash["name"]]
  end

  def check_verification_code(summoner_id, code)
    return false unless summoner_id
    begin
      url = open("https://br1.api.riotgames.com/lol/platform/v3/third-party-code/by-summoner/#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string
    rescue
      return false
    end

    verification_hash = JSON.parse url
    return verification_hash == code.downcase
  end

  def get_tier_rank(summoner_id)
    return false unless summoner_id
    url = open("https://br1.api.riotgames.com/lol/league/v3/positions/by-summoner/#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

    rank_array = JSON.parse url

    tier = 'UNRANKED'
    rank = nil
    rank_array.each do |queue_hash|
      next unless queue_hash["queueType"] == "RANKED_SOLO_5x5"
      tier = queue_hash["tier"]
      rank = queue_hash["rank"]
    end

    [tier, rank]
  end
end
