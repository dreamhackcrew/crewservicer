class TShirtOrder < ActiveRecord::Base
  extend Enumerize

  belongs_to :event
  belongs_to :person

  enumerize :model, in: [ :crew, :gift ]
  enumerize :size, in: [ :unisex_xs, :unisex_s, :unisex_m, :unisex_l, :unisex_xl,
                         :unisex_xxl, :unisex_3xl, :unisex_4xl, :unisex_5xl, :unisex_6xl ]

  validates_presence_of :event
  validates_presence_of :person
  validates_presence_of :model
  validates_presence_of :size
end
