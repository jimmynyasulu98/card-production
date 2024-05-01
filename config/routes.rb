Rails.application.routes.draw do

  resources :cards
  resources :academic_years
  resources :members
  resources :covers
  resources :locations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  root "members#new"
  get 'student/select-list', to: 'student#index' , as: :select_student_list
  post 'student/select-list', to: 'student#select_student_list', as: :student_list
  get 'student/select-student', to: 'student#index'
  post 'student/select-student', to: 'student#select_student',as: :select_student
  post 'student/mark-printed', to: 'student#mark_printed',as: :mark_printed
  post 'student/mark-printed_manual', to: 'student#mark_printed_manual',as: :mark_printed_manual
  get 'student/new_student_list'
  post 'student/create_student_list', as: :create_student_list
end
