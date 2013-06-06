require 't_shirt_import'

namespace :t_shirt_import do
  desc 'Import t-shirts from a file'
  task :process, [ :model, :person_id, :file ] => :environment do |t, args|
    model = args.model.to_sym
    event = Event.active.order('start ASC').first
    person = Person.find(args.person_id.to_i)

    if model.nil? || event.nil? || person.nil?
      exit 'Arguments were not valid'
    end

    cco_access_token = OAuth::AccessToken.from_hash(
      CrewCornerOauth.consumer,
      oauth_token: person.cco_access_token,
      oauth_token_secret: person.cco_access_token_secret
    )

    File.open(args.file) do |file|
      import = TShirtImport.new(model, file, event, access_token: cco_access_token)

      import.process

      puts "#{import.imported_orders.size} successfully imported order(s)"

      if import.failed_orders.size > 0
        puts 'Failed orders:'
        import.failed_orders.each do |failed_order|
          puts "#{failed_order[:username]},#{failed_order[:size]}"
        end
      end
    end
  end
end
