Rails.application.routes.draw do
  get 'user_info', to: 'users#user_info'
  get 'payments', to: 'users#user_payments'
  get 'transactions', to: 'users#user_transactions'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
