require 'benchmark/memory'

Benchmark.memory do |x|
  x.report("ActiveRecord::FinderMethods#find") do
    SampleUser.find_by(id: 5000)
  end
  x.report("Enumerable#find(id = 5000)") do
    SampleUser.all.find { |sample_user| sample_user.id == 5000 }
  end
  x.report("find x group_by") do
    SampleUser.all.group_by(&:id)[5000].first
  end
  x.compare!
end
