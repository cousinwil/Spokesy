module StravaHelper

  require 'net/http'
  require 'json'
  require 'date'

  class StravaApiHelper < Struct.new(:base_url)

    def get(service, params = {})
      url = "http://#{self.base_url or "www.strava.com"}/api/v1/#{service}"
      # escape strings and format dates and times
      params.each_pair do |k, v|
        params[k] = URI.escape(v) if v.is_a? String
        params[k] = v.strftime("%Y-%m-%d") if v.is_a? Date
        params[k] = v.strftime("%Y-%m-%dT%H:%M:%S") if v.is_a? Time
      end

      url << "?#{params.map{|k, v| "#{k}=#{v}"}.join("&")}" if !params.empty?
      JSON.parse(Net::HTTP.get(URI.parse(url)))
    end

  end
end 