# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  sex         :string(1)        not null
#  color       :string           not null
#  birth_date  :date             not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # .freeze renders a constant immutable.
  CAT_COLORS = %w(black white orange brown).freeze

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)
  validates :birth_date, :color, :name, :sex, :owner, presence: true

  # Remember, has_many is just a method where the first argument is
  # the name of the association, and the second argument is an options
  # hash.
  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner,
    class_name: :User,
    foreign_key: :user_id

  def age
    time_ago_in_words(birth_date)
  end
end
