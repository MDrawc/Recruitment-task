require 'net/https'

module V1
  class SearchIpstack < ApplicationService
    BASE_URL = 'http://api.ipstack.com/'

    def initialize(input:, build_resp: true)
      @input = input
      @build_resp = build_resp
    end

    def call
      convert_input
      ask_ip_stack
      if @build_resp
        build_response
      else
        return @results
      end
    end

    private

    def convert_input
      hostname = URI.parse(CGI.unescape(@input)).host rescue nil
      @input = hostname || @input
    end

    def ask_ip_stack
      query_params = { 'access_key' => ENV['IP_STACK'],
                       'hostname' => 1,
                       'fields' => 'main' }

      url = URI(BASE_URL + @input)
      url.query =  URI.encode_www_form(query_params)

      http = Net::HTTP.new(url.host, url.port);
      request = Net::HTTP::Get.new(url)

      @results = JSON.parse http.request(request).body
    end

    def build_response
      response = { input: @input,
                   message: 'Record DOES NOT exists in our db',
                   data_source: BASE_URL,
                   data: @results }
    end
  end
end


