class Message < ActiveRecord::Base
  belongs_to :event

  attr_accessible :published_at, :deleted_at, :headline, :text, :on_site, :on_info_screen, :sort_priority

  validates_presence_of :event, :headline, :text, :sort_priority
  validates_inclusion_of :on_site, in: [ true, false ]
  validates_inclusion_of :on_info_screen, in: [ true, false ]

  scope :active, where('deleted_at IS NULL')
  scope :deleted, where('deleted_at IS NOT NULL')
  scope :published, where('published_at < ? AND deleted_at IS NOT NULL')
end
