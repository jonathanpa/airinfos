class TestJob
  @queue = :test_job_queue

  def self.perform
    puts "Test job -- #{DateTime.now.to_formatted_s(:db)} --"
  end

end
