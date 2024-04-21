Rails.application.routes.draw do

  resources :cards
  resources :academic_years
  resources :members
  resources :covers
  resources :locations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  root "members#new"
  get 'student/index'
  get 'student/new_student_list'
  post 'student/create_student_list', as: :create_student_list
end
