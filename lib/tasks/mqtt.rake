namespace :mqtt do
  desc "Start the mqtt reader"
  task run_reader: :environment do
    Resque.enqueue(QueueJob)
  end
end
