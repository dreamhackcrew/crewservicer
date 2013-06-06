class TShirtImport
  attr_reader :model
  attr_reader :file
  attr_reader :event
  attr_reader :imported_orders
  attr_reader :failed_orders
  attr_reader :cco_options

  SIZES = { 'Unisex S' => :unisex_s, 'Unisex M' => :unisex_m, 'Unisex L' => :unisex_l,
            'Unisex XL' => :unisex_xl, 'Unisex XXL' => :unisex_xxl,
            'Unisex XXXL' => :unisex_3xl, 'Unisex XXXXL' => :unisex_4xl,
            'Unisex XXXXXL' => :unisex_5xl, 'Unisex XXXXXXL' => :unisex_6xl }

  def initialize(model, file, event, cco_options = {})
    @model = model
    @file = file
    @event = event
    @imported_orders = []
    @failed_orders = []
    @cco_options = cco_options
  end

  def process
    ActiveRecord::Base.transaction do
      file.each_line do |line|
        username, size = line.split("\t")

        create_order(username, size)
      end
    end
  end

  private

  def create_order(username, size_string)
    person = find_person(username)

    unless person
      Rails.logger.info("Tried creating t-shirt order of model \"#{@model}\" in size \"#{size_string}\", but couldn't find cco user with name \"#{username}\"")
      @failed_orders << { username: username, size: size_string }
      return
    end

    size = SIZES[size_string.strip]

    unless size
      Rails.logger.info("Tried creating t-shirt order of model \"#{@model}\" in size \"#{size_string}\", but couldn't translate the size.")
      @failed_orders << { username: username, size: size_string }
      return
    end

    person.save

    order = TShirtOrder.create({
      event: @event,
      person: person,
      model: @model,
      size: size
    })

    @imported_orders << order

    Rails.logger.info("Created t-shirt order ##{order.id} – person: #{person.username}, model: #{@model}, size: #{order.size}")
  end

  def find_person(username)
    users = CrewCorner::User.search(username, @cco_options.dup)

    user = users.detect { |user| user.username.casecmp(username) == 0 } if users.kind_of?(Array)

    Person.find_or_update_by_cco_user(user) unless user.nil?
  end
end
