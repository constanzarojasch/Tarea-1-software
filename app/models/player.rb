class Player < ApplicationRecord
  belongs_to :team, class_name: "Team", foreign_key:"team_id", dependent: :destroy
  validates :name, presence: true 
  validates :goal, presence: true 
  validates :assist, presence: true 
  validates :goal, numericality: { only_integer: true }
  validates :assist, numericality: { only_integer: true }
  validates :card, numericality: { only_integer: true }
  validates :card, presence: true 
  #default capacity
end
