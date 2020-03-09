module V1
  class CreateIpRecord < ApplicationService
    attr_reader :status

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
          @message = 'Problem with ipstack'
          @errors[:main] = 'problem with ipstack'
          @status = :unprocessable_entity
        end
      end

      return response, @status
    end

    private

    def record_already_exists
      if @data = V1::FindIpRecord.call(input: @input, build_resp: false)
        @message = 'Record with such input ALREADY EXISTS'
        @errors[:main] = 'record with such input already exists'
        @source = 'local_db'
        @status = :unprocessable_entity
        return true
      end
    end

    def found_on_ip_stack
      @data = V1::SearchIpstack.call(input: @input, build_resp: false)
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
                   message: @message,

      }

      response[:errors] = @errors if !@errors.empty?

      data = { data_source: @source,
               data: @data
      }

      response = response.merge(data)
    end
  end
end
