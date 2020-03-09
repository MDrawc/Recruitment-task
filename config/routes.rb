Rails.application.routes.draw do
  namespace 'v1' do

    resources :ip_records, only: [:index]
    get '/:input', to: 'ip_records#show', constraints: { input: /.*/ }
    post '/:input', to: 'ip_records#create', constraints: { input: /.*/ }
    delete '/:input', to: 'ip_records#destroy', constraints: { input: /.*/ }
  end
end
