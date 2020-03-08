class V1::IpRecordsController < ApplicationController
  before_action :unescape_params, only: [:show]

  def index
    @ip_records = IpRecord.all
    render json: @ip_records, status: :ok
  end

  def show
    @response = FindIpRecord.call(@query) || SearchIpstack.call(@query)
    render json: @response, status: :ok
  end

  def create

  end

  def destroy
  end

  def ip_record_params
    params.require(:ip_record).permit(:query)
  end

  private
    def unescape_params
      @query = CGI.unescape(params[:query])
    end
end
