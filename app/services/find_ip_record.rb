class FindIpRecord
  def self.call(params)
    new(params).call
  end

  def initialize(query)
    @query = query
  end

  def call
    prepare_response if find_ip_record
  end

  private

  def find_ip_record
    @results = IpRecord.find_by(query: @query)
  end

  def prepare_response
    @response = { query: @query,
                  message: 'Record EXISTS in our db',
                  data_source: 'recruitment_task_db',
                  data: @results }
  end
end



