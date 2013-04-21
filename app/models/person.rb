class Person < ActiveRecord::Base
  attr_accessible :cco_id, :username

  validates_numericality_of :cco_id
  validates_presence_of :username
  validates_inclusion_of :administrator, in: [ true, false ]

  after_initialize :set_defaults

  def self.find_or_create_by_cco_user(cco_user)
    person = Person.find_by_cco_id(cco_user.uid)

    if person.nil?
      person = Person.create(
        cco_id: cco_user.uid,
        username: cco_user.username
      )
    end

    person
  end

  def set_defaults
    self.administrator = false if administrator.nil?
  end
end
