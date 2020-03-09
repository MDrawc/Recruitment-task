module V1
  class CreateIpRecord < ApplicationService

    def initialize(input:)
      @input = input
      @errors = {}
    end

    def call
      unless record_already_exists
        if found_on_ip_stack
          create_record
          save_record
        else
          @message = 'Problem with ipstack, read ipstack errors below'
          @errors = @data['error']
          @status = :unprocessable_entity
        end
      end

      return response, @status
    end

    private
      def record_already_exists
        if @data = IpRecord.find_by(input: @input)
          @message = 'Record with such input ALREADY EXISTS'
          @source = 'local_db'
          @status = :unprocessable_entity
          return true
        end
      end

      def found_on_ip_stack
        @data = V1::SearchIpstack.call(input: @input)
        return @data['error'].nil?
      end

      def create_record
        @record = IpRecord.new(@data.except('type'))
        @record.input = @input
        @record.ip_type = @data['type']
      end

      def save_record
        if @record.save
          @message = 'Record successfuly CREATED'
          @data = @record
          @source = 'local_db'
          @status = :ok
        else
          @errors[:record] = @record.errors
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
