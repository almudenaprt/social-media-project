class Tweet < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validates :message, length: {maximum: 140, too_long: "Un tweet sólo tiene 140 caracteres. ¡Todo el mundo lo sabe!"}

end
