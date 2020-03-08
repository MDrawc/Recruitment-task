Rails.application.routes.draw do

  namespace 'v1' do
    resources :ip_records
  end

end
