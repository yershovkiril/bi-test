Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'by-dates', to: 'sales#by_dates'
  get 'by-month', to: 'sales#by_month'

  root 'sales#period'
  get 'sales',    to: 'sales#sales'

end
