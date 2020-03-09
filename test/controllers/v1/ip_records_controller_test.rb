require 'test_helper'

class V1::IpRecordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @existing_record = ip_records(:ip)
    @input_to_destroy = CGI.escape(ip_records(:url).input)
  end

  #INDEX ACTION:
  test 'retrieve all saved records' do
    get v1_ip_records_path
    response = JSON.parse(@response.body)
    assert_response :success

    size = response.size
    assert_equal IpRecord.count , size

    ips = response.pluck('ip')
    assert_equal IpRecord.all.pluck(:ip), ips
  end

  #SHOW ACTION:
  test 'show existing record' do
    input = @existing_record.input
    get v1_path(input: input)
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record EXISTS in our db' , message

    source = response['data_source']
    assert_equal 'local_db' , source

    latitude = response['data']['latitude']
    assert_equal latitude, @existing_record.latitude
  end

  test 'show not existing ip using ip stack' do
    get v1_path(input: 'www.youtube.com')
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record DOES NOT exists in our db' , message

    source = response['data_source']
    assert_equal 'http://api.ipstack.com/' , source

    latitude = response['data']['latitude']
    assert_not_nil latitude
  end

  #CREATE ACTION:
  test 'create new record' do
    post v1_path(input: 'www.kotaku.com')
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record successfuly CREATED' , message

    latitude = response['data']['latitude']
    assert_not_nil latitude
  end

  test 'create new url record' do
    post v1_path(input: 'https://www.kotaku.com')
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record successfuly CREATED' , message

    latitude = response['data']['latitude']
    assert_not_nil latitude
  end

  test 'create stupid record' do
    post v1_path(input: 'stupid')
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record successfuly CREATED' , message

    latitude = response['data']['latitude']
    assert_nil latitude
  end

  test 'create already existing record' do
    input = @existing_record.input
    post v1_path(input: input)
    response = JSON.parse(@response.body)
    assert_response :unprocessable_entity

    message = response['message']
    assert_equal 'Record with such input ALREADY EXISTS' , message

    latitude = response['data']['latitude']
    assert_equal latitude, @existing_record.latitude
  end

  #DESTROY ACTION:
  test 'destroy saved record' do
    delete v1_path(input: @input_to_destroy)
    response = JSON.parse(@response.body)
    assert_response :success

    message = response['message']
    assert_equal 'Record DESTROYED', message
  end

  test 'destroy unexisting record' do
    delete v1_path(input: 'www.abbreviations.com')
    response = JSON.parse(@response.body)

    assert_response :unprocessable_entity

    message = response['message']
    assert_equal 'Record NOT FOUND', message
  end
end
