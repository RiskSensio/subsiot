namespace :mqtt do
  desc "Start the mqtt reader"
  task run_reader: :environment do
    QueueJob.perform('fa2bb0ad-7610-4eaa-b0ca-10a3bcec1767', '7eLjm5NYB9De')
   # Resque.enqueue(QueueJob, 'fa2bb0ad-7610-4eaa-b0ca-10a3bcec1767', '7eLjm5NYB9De')
    # Resque.enqueue(QueueJob, 'b3f3ce5b-770c-408d-9536-36c0599f4f7d', 'IpjPtR0cq69A')
    # Resque.enqueue(QueueJob, '818ec1c6-6c0f-4faf-84e4-57036d53d55e', 'MbCm0I7rwkAA')
    # Resque.enqueue(QueueJob, '7f7f055a-7e7c-4cb6-8de1-404bd905fd81', 'qzHw3lxvdYb2')
    # Resque.enqueue(QueueJob, 'e63c9313-f038-4e2b-a5ea-87d6f22df9fd', 'i0hAVD7LC0xh')
    # Resque.enqueue(QueueJob, '7e5045b1-3bdd-49f2-8a8f-24740ca931b0', '6rf4Uqg1YM6q')
    # Resque.enqueue(QueueJob, '277e930c-4d8d-4bf3-bcff-beddafd51647', 'Ncj9sI1spoqr')
    # Resque.enqueue(QueueJob, '1a0674b8-b48b-42b3-9d09-4e06e7fdd83f', 'r9TZwh6iLm_f')

    # Add adam's stuff
    Resque.enqueue(QueueJob, '452411b1-6b68-4fa6-b9f2-7c5d0b7b7c2d', 'C4a4C4UWYtPj')
  end
end
