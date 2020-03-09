module V1
  class ProvideIpData < ApplicationService

    def initialize(input:)
      @input = input
      @errors = {}
    end

    def call
      find_on_ip_stack unless ip_record_exists
      return response, @status
    end

    private
      def ip_record_exists
        if @data = IpRecord.find_by(input: @input)
          @message = 'Record EXISTS in db'
          @source = 'db'
          @status = :ok
          return true
        end
      end

      def find_on_ip_stack
        @data = V1::SearchIpstack.call(input: @input)
        if @data['error'].nil?
          @source = 'kicui'
          @status = :ok
        else
          @message = 'Problem with ipstack, read ipstack errors below'
          @errors = @data['error']
          @status = :unprocessable_entity
        end
      end

      def response
        response = { input: @input,
                     message: @message }

        if @errors.empty?
          data = { data_source: @source,
                   data: @data }
          response = response.merge(data)
        else
          response[:errors] = @errors
        end

        response
      end
  end
end
