# frozen_string_literal: true

class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps
  field :end_date, type: Date
  embeds_many :goals
end
