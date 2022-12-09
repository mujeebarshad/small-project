# frozen_string_literal: true

class Vessel < ApplicationRecord
  scope :by_name, -> { order(name: :asc) }

  belongs_to :organization
  has_many :employments

  validates_presence_of :name

  def delete_vessel_and_move_users?(target_vessel)
    # Defensive Check (Assuming do not delete the vessel when target vessel and existing vessel are same)
    return false if target_vessel&.id == id

    Vessel.transaction do
      employments.update_all(vessel_id: target_vessel&.id)
      destroy!
      destroyed?
    end
  rescue StandardError
    false
  end
end
