module Cancelable
  extend ActiveSupport::Concern
  included do
    scope :uncanceled, -> { where(canceled: false) }
  end

  def canceled!
    update(canceled: true)
  end

  def uncanceled!
    update(canceled: false)
  end
end
