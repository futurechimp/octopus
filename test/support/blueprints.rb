Sham.url { "http://" + Faker::Internet.domain_name }
Sham.last_modified_hash {"foo#{rand(100000).to_s}".hash}
Sham.body { Faker::Lorem.sentence }

NetResource.blueprint do
  url
  last_modified_hash
  update_period { 30 }
  next_update { DateTime.now + 30 }
  body
  created_at DateTime.now
  updated_at DateTime.now
end

Subscription.blueprint do
  url
  created_at DateTime.now
  updated_at DateTime.now
end

