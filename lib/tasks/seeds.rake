# frozen_string_literal: true

Rake::Task["db:seed:development"].clear
namespace :db do
  namespace :seed do
    task development: :environment do
      Rake::Task["db:seed:development:base"].execute
    end
  end
end
