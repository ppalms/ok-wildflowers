namespace :e2e do
  desc "Clean, precompile assets, and run system tests"
  task run: :environment do
    puts "Cleaning old assets..."
    system("RAILS_ENV=test bin/rails assets:clobber")

    puts "Precompiling assets..."
    system("RAILS_ENV=test bin/rails assets:precompile")

    puts "Running system tests..."
    system("bin/rails test:system")
  end
end
