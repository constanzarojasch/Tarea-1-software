class Match < ApplicationRecord
  has_one :teamA, class_name: "Team", foreign_key: "teamA_id"
  has_one :teamB, class_name: "Team", foreign_key: "teamB_id"
  validates_presence_of:"teamA_id", "teamB_id"
end