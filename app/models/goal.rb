# frozen_string_literal: true

class Goal
  include Mongoid::Document
  include Mongoid::Timestamps
  field :text, type: String, default: ''
  field :is_achieved, type: Mongoid::Boolean, default: false
  embedded_in :sprint
end
