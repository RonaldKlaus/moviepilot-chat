class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  # !It has to be after_create_commit, cause otherwise it is not in the db yet
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  after_update_commit { MessageBroadcastJob.perform_later(self, "update") }
  before_destroy { MessageBroadcastJob.perform_later(self.id, "destroy") }
end
