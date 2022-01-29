class Message < ApplicationRecord
    has_many :likes
    belongs_to :user

    validates :content, presence: true
end
