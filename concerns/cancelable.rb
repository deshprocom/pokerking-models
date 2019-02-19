module Cancelable
  extend ActiveSupport::Concern
  included do
    scope :canceled, -> { where(canceled: true) }
  end

  def canceled!
    update(canceled: true)
  end

  def uncanceled!
    update(canceled: false)
  end
end
