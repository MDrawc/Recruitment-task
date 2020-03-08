require 'net/https'

class SearchIpstack
  BASE_URL = 'http://api.ipstack.com/'

  def self.call(params)
    new(params).call
  end

  def initialize(query)
    @query = query
  end

  def call
    convert_query
    ask_ip_stack
    prepare_response
  end

  private

  def convert_query
    hostname = URI.parse(CGI.unescape(@query)).host rescue nil
    @query = hostname || @query
  end

  def ask_ip_stack
    query_params = { 'access_key' => ENV['IP_STACK'],
                     'hostname' => 1,
                     'fields' => 'main' }

    url = URI(BASE_URL + @query)
    url.query =  URI.encode_www_form(query_params)

    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Get.new(url)

    @results = JSON.parse http.request(request).body
  end

  def prepare_response
    @response = { query: @query,
                  message: 'Record DOES NOT exists in our db',
                  data_source: BASE_URL,
                  data: @results }
  end
end



