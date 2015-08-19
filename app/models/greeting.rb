class Greeting < ActiveRecord::Base
  serialize :message, Hash
end

# データを登録
@greeting.message = {:en => "Hello World", :ja => "こんにちは、世界"}