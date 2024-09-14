# Gardenerd

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails) [![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Dev notes

- Run e2e tests after making changes

  - `bin/rails e2e:run`

- Need to nuke local dev db but "being accessed by other users" due to zombie process

  - ps -ef | grep postgres
  - sudo kill -9 <postgresid>

- Run in production mode (e.g., to test custom error pages)

  - `RAILS_ENV=production bundle exec bin/rails assets:precompile`
  - `bin/rails s -e production`
