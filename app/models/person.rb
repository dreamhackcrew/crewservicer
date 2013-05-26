class Person < ActiveRecord::Base
  attr_accessible :cco_id, :username, :administrator

  validates_numericality_of :cco_id
  validates_presence_of :username
  validates_inclusion_of :administrator, in: [ true, false ]

  after_initialize :set_defaults

  def self.find_or_update_by_cco_user(cco_user)
    person = Person.find_or_initialize_by_cco_id(cco_user.uid)

    person.username = cco_user.username

    person
  end

  def to_param
    cco_id
  end

  def set_defaults
    self.administrator = false if administrator.nil?
  end
end
