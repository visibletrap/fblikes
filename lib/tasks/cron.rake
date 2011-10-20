task :cron => :environment do
  ScoresController.new.update
end
