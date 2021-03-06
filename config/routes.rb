Rails.application.routes.draw do
  namespace :api do
    resources :subjects, only: [], id: /[A-Z0-9\.]+?/i do
      resources :outcomes, only: [:index]
    end
  end

  namespace :manage_assignments do
    root "dashboard#show"

    resources :attachments, only: [:show, :destroy]

    resources :courses, only: [:index, :show] do
      resources :coverages, only: [:new, :edit, :create, :update]
    end

    resources :outcome_coverages, only: [:destroy] do
      resources :assignments, only: [:new, :edit, :create, :update]
    end
  end

  namespace :manage_outcomes do
    resources :courses, only: [] do
      resources :standard_outcomes, only: [:index, :create]
      resources :outcomes, only: [:index, :new, :create]
    end

    resources :outcomes, only: [:edit, :update]
    root "dashboard#show"
  end

  namespace :manage_results do
    resources :assignments, only: [:show] do
      resources :results, only: [:new, :create]
    end

    resources :results, only: [:edit, :update, :destroy]
    resources :subjects, only: [:index, :show]
  end

  namespace :gradebooks do
    get "subjects/:subject_id/gradebook",
      format: :js,
      to: "gradebooks#show",
      as: :gradebook

    get "subjects/:subject_id/:semester/:year/gradebook_assignments",
      to: "gradebook_assignments#index",
      as: :gradebook_assignments

    resources :gradebook_assignments, only: [] do
      resource :histogram, only: [:show]
    end
  end

  scope :reports, module: :reports do
    resources :courses, only: [] do
      resource :assignment_report, only: [:show]
    end

    root to: "courses#index", as: :reports
  end

  resources :activities, only: [:index]

  get "/pages/*id" => "pages#show", as: :page, format: false
  root "manage_outcomes/dashboard#show"
end
