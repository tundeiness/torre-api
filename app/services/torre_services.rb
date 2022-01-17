class TorreService 
  def self.get_person_by_username(username)
    response = Faraday.get("https://torre.bio/api/bios/#{username}")
    JSON.parse(response)
  end

  def self.get_opportunity_by_id(id)
    response = Faraday.get("https://torre.co/api/suite/opportunities/#{id}")
    JSON.parse(response)
  end
end
