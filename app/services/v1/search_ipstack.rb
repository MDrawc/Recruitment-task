require 'net/https'

module V1
  class SearchIpstack < ApplicationService
    BASE_URL = 'http://api.ipstack.com/'
    QUERY_PARAMS = { 'access_key' => ENV['IP_STACK'],
                     'hostname' => 1,
                     'fields' => 'main' }

    def initialize(input:)
      @input = input
    end

    def call
      convert_input
      ask_ip_stack
    end

    private
      def convert_input
        hostname = URI.parse(CGI.unescape(@input)).host rescue nil
        @input = hostname || @input
      end

      def ask_ip_stack
        begin
          url = URI(BASE_URL + @input)
          url.query =  URI.encode_www_form(QUERY_PARAMS)
          http = Net::HTTP.new(url.host, url.port);
          request = Net::HTTP::Get.new(url)

          @results = JSON.parse http.request(request).body
        rescue
          { 'error' => 'unable to connect to ipstack api' }
        end
      end
  end
end
