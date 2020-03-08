class V1::IpRecordsController < ApplicationController

  def show

    query = CGI.unescape(params[:query])

    @results = SearchIpstack.call(query: query)

    render json: { message: 'Helo2!',
                   query: query,
                   response: @results }, status: :ok
  end

  def create
  end

  def destroy
  end

  def ip_record_params
    params.require(:ip_record).permit(:query)
  end
end
