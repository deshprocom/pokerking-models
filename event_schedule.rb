class EventSchedule < ApplicationRecord
  mount_uploader :schedule_pdf, PdfUploader

  belongs_to :main_event
  after_initialize do
    self.begin_time ||= Time.current
    self.reg_open ||= Time.current
    self.reg_close ||= Time.current
  end
end
