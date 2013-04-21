# Crewservicer

Tool for internal information exchange and keeping track of crew. Information dashboard for
everyone in a team and tools restricted to event administrators.

## Getting started

### Prerequisites

- Ruby 2.0
- Bundler
- PostgreSQL 9.2 (you could probably use others but there are no guarantees)

### Steps

- Clone repo
- Set up a user with database creation privileges
- `cd crewservicer`
- Create `config/database.yml`, `config/initializers/crew_corner_oauth.rb`, `config/initializers/secret_token.rb` from examples
- `bundle`
- `bundle exec rake db:create`
- `bundle exec rake db:schema:load`