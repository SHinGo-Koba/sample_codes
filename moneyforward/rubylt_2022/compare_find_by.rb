require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(
    time: 10, # default 5
    warmup: 3 # default 2
  )
  sample_users = SampleUser.all

  x.report("ActiveRecord::FinderMethods#find_by(id: 1000)") do
    SampleUser.find_by(id: 1000)
  end
  x.report("Enumerable#find(id == 1000)") do
    sample_users.find { |sample_user| sample_user.id == 1000 }
  end
  x.report("Enumerable#find(id == 3000)") do
    sample_users.find { |sample_user| sample_user.id == 3000 }
  end
  x.report("Enumerable#find(id == 10000)") do
    sample_users.find { |sample_user| sample_user.id == 10000 }
  end
  x.compare!
end
