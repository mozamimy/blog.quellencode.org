#!/usr/bin/env ruby
# encoding: utf-8
# example05.rb

3.times do
  FactryGirl.create(:girl).tap do |user|
    FactryGirl.create(:perfume, user_id: user.id)
    FactryGirl.create(:rouge, user_id: user.id)
    FactryGirl.create(:manicure, user_id: user.id)
  end
end
