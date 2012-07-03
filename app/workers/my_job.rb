class MyJob
  @queue = :my_job_queue

  def self.perform
    puts "Doing my job at -- #{DateTime.now.to_formatted_s(:db)} --"
  end
end
