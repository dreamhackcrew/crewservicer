class Message < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :event, :headline, :text, :sort_priority
  validates_inclusion_of :on_site, in: [ true, false ]
  validates_inclusion_of :on_info_screen, in: [ true, false ]

  scope :active, ->{ where('deleted_at IS NULL') }
  scope :deleted, ->{ where('deleted_at IS NOT NULL') }
  scope :published, ->{ where('published_at < ? AND deleted_at IS NULL', Time.now) }
  scope :on_site, ->{ where('on_site IS TRUE') }
  scope :on_info_screen, ->{ where('on_info_screen IS TRUE') }
end
