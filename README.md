# Gardenerd

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails) [![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide) [![CI Build](https://github.com/ppalms/ok-wildflowers/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ppalms/ok-wildflowers/actions/workflows/ci.yml)

## Dependencies

- Ruby 3.2.4
- Docker

## Getting Started

Run `bin/setup` from the project root. The setup script will take care of the following:

- Install application gems
- Create a development database in a Docker container
- Prepare the database and run all migrations

Run `bin/dev` to run the app at *http://localhost:3000*

## Infrastructure

### DigitalOcean
- App droplet (1 GB Memory / 25 GB Disk - Ubuntu 24.04 (LTS) x64)
- Database droplet (1 GB Memory / 25 GB Disk - Ubuntu 24.04 (LTS) x64)

### AWS
- S3 bucket for [Active Storage](https://guides.rubyonrails.org/active_storage_overview.html)
- SES configuration for [Action Mailer](https://guides.rubyonrails.org/action_mailer_basics.html)
- IAM user account for sending email

## Dev notes

- Run e2e tests after making changes

  - `bin/rails e2e:run`

- Run in production mode (e.g., to test custom error pages)

  - `RAILS_ENV=production bundle exec bin/rails assets:precompile`
  - `bin/rails s -e production`

- Search production logs
  - `kamal app logs -g <request ID or something else>`

