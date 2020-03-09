module V1
  class FindIpRecord < ApplicationService

    def initialize(input:, build_resp: true)
      @input = input
      @build_resp = build_resp
    end

    def call
      find_ip_record
      if @build_resp
        build_response if @record
      else
        return @record
      end
    end

    private

    def find_ip_record
      @record = IpRecord.find_by(input: @input)
    end

    def build_response
      response = { input: @input,
                   message: 'Record EXISTS in our db',
                   data_source: 'local_db',
                   data: @record }
    end
  end
end
