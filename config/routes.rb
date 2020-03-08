Rails.application.routes.draw do
  namespace 'v1' do


    resources :ip_records, only: [:index]

    get '/:query', to: 'ip_records#show', constraints: { query: /.*/ }, as: 'provide'





    # post '/:query', to: 'ip_records#show', constraints: { query: /.*/ }, as: 'add'
    # delete '/:query', to: 'ip_records#show', constraints: { query: /.*/ }, as: 'delete'
  end
end
