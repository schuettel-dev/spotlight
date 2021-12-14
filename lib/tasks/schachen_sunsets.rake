namespace :schachen_sunsets do
  desc 'Print Schachen sunsets as yaml'
  task as_yaml: :environment do
    puts SchachenSunTimes.new.to_yaml
  end
end
