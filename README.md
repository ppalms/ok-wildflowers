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

## Dev playbook

- Need to nuke local dev db but "being accessed by other users" due to zombie process

  1. ps -ef | grep postgres
  2. sudo kill -9 <postgresid>

- Run in production mode (e.g., to test custom error pages)
  - `bin/rails s -e production`
