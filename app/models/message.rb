class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # !It has to be after_create_commit, cause otherwise it is not in the db yet
  after_create_commit { MessageBroadcastJob.perform_later(self, self.chat_room_id, "create") }
  before_destroy { MessageBroadcastJob.perform_later(self.id, self.chat_room_id, "destroy") }
end
