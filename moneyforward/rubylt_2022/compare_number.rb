require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(
    time: 10, # default 5
    warmup: 3 # default 2
  )
  sample_users = SampleUser.all

  x.report("id: 1") do
    sample_users.find { |sample_user| sample_user.id == 1 }
  end
  x.report("id: 10") do
    sample_users.find { |sample_user| sample_user.id == 10 }
  end
  x.report("id: 100") do
    sample_users.find { |sample_user| sample_user.id == 100 }
  end
  x.report("id: 1000") do
    sample_users.find { |sample_user| sample_user.id == 1000 }
  end
  x.report("id: 10000") do
    sample_users.find { |sample_user| sample_user.id == 10000 }
  end
  x.compare!
end
