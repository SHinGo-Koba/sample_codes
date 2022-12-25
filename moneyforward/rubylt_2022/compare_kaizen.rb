require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(
    time: 10, # default 5
    warmup: 3 # default 2
  )

  id = 9000
  sample_users = SampleUser.all
  group_by_sample_users = sample_users.group_by(&:id)

  x.report("find_by") do
    SampleUser.find_by(id: id)
  end
  x.report("find") do
    sample_users.find { |sample_user| sample_user.id == id }
  end
  x.report("find x reverse") do
    sample_users.reverse.find { |sample_user| sample_user.id == id }
  end
  x.report("group_by") do
    sample_users.group_by(&:id)[id].first
  end
  x.report("pre_group_by") do
    group_by_sample_users[id].first
  end
  x.report("each_slice(1000)") do
    sample_users.each_slice(1000) do |sliced_sample_users|
      if ((sliced_sample_users.first.id)..(sliced_sample_users.last.id)).include?(id)
        break sliced_sample_users.find { |sample_user| sample_user.id == id }
      end
    end
  end
  x.compare!
end
