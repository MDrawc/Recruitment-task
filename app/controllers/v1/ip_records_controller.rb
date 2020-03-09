class V1::IpRecordsController < ApplicationController
  before_action :unescape_params, only: [:show, :destroy]

  def index
    ip_records = IpRecord.all
    render json: ip_records, status: :ok
  end

  def show
    response = V1::FindIpRecord.call(input: @input) || V1::SearchIpstack.call(input: @input)
    render json: response, status: :ok
  end

  def create
    response, status = V1::CreateIpRecord.call(input: ip_record_params[:input])
    render json: response, status: status
  end

  def destroy
    response, status = V1::DeleteIpRecord.call(input: @input)
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
