module ApplicationHelper

  require 'securerandom'
  require 'open-uri'

  RIOT_API_URL = "https://br1.api.riotgames.com/lol/"
  SUMM_URL = RIOT_API_URL + "summoner/v3/summoners/by-name/"
  CODE_URL = RIOT_API_URL + "platform/v3/third-party-code/by-summoner/"
  ELO_URL = RIOT_API_URL + "league/v3/positions/by-summoner/"

  def generate_key
    "soloq#{SecureRandom.hex(4)}"
  end

  def get_summoner_id_name(summoner_name)
    return false if summoner_name.length > 16 || summoner_name.length < 1

    url_rdy_name = summoner_name.gsub(' ', '%20')

    url = open(SUMM_URL + "#{url_rdy_name}?api_key=#{ENV["RIOT_KEY"]}").string

    summoner_hash = JSON.parse url
    [summoner_hash["id"], summoner_hash["name"]]
  end

  def check_verification_code(summoner_id, code)
    return false unless summoner_id
    begin
      url = open(CODE_URL + "#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string
    rescue
      return false
    end

    verification_hash = JSON.parse url
    return verification_hash == code.downcase
  end

  def get_tier_rank(summoner_id)
    return false unless summoner_id

    url = open(ELO_URL + "#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

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
