module V1
  class DeleteIpRecord < ApplicationService

    def initialize(input:)
      @input = input
    end

    def call
      if find_record
        destroy_record
      else
        @message = 'Record NOT FOUND'
        @status = :unprocessable_entity
      end

      return response, @status
    end

    private

    def find_record
      @record = IpRecord.find_by(input: @input)
    end

    def destroy_record
      if @record.destroy
        @message = 'Record DESTROYED'
        @status = :ok
      else
        @message = 'Record NOT DESTROYED'
        @status = :unprocessable_entity
      end
    end

    def response
      response = { input: @input,
                   message: @message,

      }

      response = response.merge({ data: @record }) if @record

      response
    end
  end
end


