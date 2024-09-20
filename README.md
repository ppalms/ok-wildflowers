# Gardenerd

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails) [![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)

## Dependencies

- Ruby 3.2.4
- Docker

## Getting Started

Run `bin\setup` from the project root. The setup script will take care of the following:

- Install application gems
- Create a development database in a Docker container
- Prepare the database and run all migrations

Run `bin\dev` to run the app at *http://localhost:3000*

## Dev notes

- Run e2e tests after making changes

  - `bin/rails e2e:run`

- Run in production mode (e.g., to test custom error pages)

  - `RAILS_ENV=production bundle exec bin/rails assets:precompile`
  - `bin/rails s -e production`
