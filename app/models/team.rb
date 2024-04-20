class Team < ApplicationRecord
    has_many:players, class_name: "Player", foreign_key:"team_id", dependent: :destroy
    has_many :matches_as_team_a, foreign_key: "teamA_id", class_name: "Match", dependent: :destroy
    has_many :matches_as_team_b, foreign_key: "teamB_id", class_name: "Match" , dependent: :destroy
    validates :name, presence: true 
    validates :stadium, presence: true 
    validates :capacity, presence: true 
    validates :capacity, numericality: { only_integer: true }
    validates :city, presence: true 
end
