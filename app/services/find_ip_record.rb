class FindIpRecord < ApplicationService

  def initialize(input:, build_resp: true)
    @input = input
    @build_resp = build_resp
  end

  def call
    find_ip_record
    if @build_resp
      build_response
    else
      return @results
    end
  end

  private

  def find_ip_record
    @results = IpRecord.find_by(input: @input)
  end

  def build_response
    response = { input: @input,
                 message: 'Record EXISTS in our db',
                 data_source: 'local_db',
                 data: @results }
  end
end

