class UpdateUserAccountServiceKeyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.where(:account_key => nil).each do |user|
      Rails.logger.info user.inspect
      user.generate_account_key
    end
  end
end
