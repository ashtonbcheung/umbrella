GMAPS_KEY = "AIzaSyDKz4Y3bvrTsWpPRNn9ab55OkmcwZxLOHI"
PIRATE_WEATHER_KEY = "3RrQrvLmiUayQ84JSxL8D2aXw99yRKlx1N4qFDUE"

require "http"
require "json"

location = "What is your location"

pp location

userLocation = gets.chomp

pp "Checking the location at " + userLocation

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{userLocation}&key=#{GMAPS_KEY}"

gmaps_location = "a"

raw_gmaps = HTTP.get(gmaps_url)

parsed_gmaps = JSON.parse(raw_gmaps)

gmaps_location = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location")
lat = gmaps_location.fetch("lat")
lng = gmaps_location.fetch("lng")

puts "Your coordinates are: " + lat.to_s + ", " + lng.to_s


pirate_weather_url = "https://api.pirateweather.net/forecast/" + PIRATE_WEATHER_KEY + "/#{lat},#{lng}"
raw_weather = HTTP.get(pirate_weather_url)
parsed_weather = JSON.parse(raw_weather)

pp parsed_weather

currently_hash = parsed_weather.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "°F"

minutely_hash = parsed_weather.fetch("minutely", false)

if minutely_hash
  next_hour_summary = minutely_hash.fetch("summary")

  puts "Next hour: #{next_hour_summary}"
end
