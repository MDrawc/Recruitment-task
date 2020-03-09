class V1::IpRecordsController < ApplicationController
  before_action :unescape_params, only: [:show, :destroy]

  def index
    ip_records = IpRecord.all
    render json: ip_records, status: :ok
  end

  def show
    response = FindIpRecord.call(input: @input) || SearchIpstack.call(input: @input)
    render json: response, status: :ok
  end

  def create
    response, status = CreateIpRecord.call(input: ip_record_params[:input])
    render json: response, status: status
  end

  def destroy
    response, status = DeleteIpRecord.call(input: @input)
    render json: response, status: status
  end

  private
    def ip_record_params
      params.permit(:input)
    end

    def unescape_params
      @input = CGI.unescape(params[:input])
    end
end
