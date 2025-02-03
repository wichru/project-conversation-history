# Project Conversation History Homey Code Challenge

A Ruby application for Homey code challenge https://allentities.notion.site/Task-Development-Team-d5aae74100544f84981972edb3d922b0

## System dependencies

* [Ruby 3.3.4]
* [Rails 7]
* [Turbo && Stimulus] - For handling form submission asynchronously.
* [Slim && ViewComponent] - Slim templates for cleaner views.
* [Rubocop] - Ruby static code analyzer
* [RSpec && Capybara] - Rspec tests && Capybara feature tests.

## Features
1. **Add comments to a project asynchronously**
2. **View comments in chronological order**
3. **Change project status asynchronously**
4. **Track project status changes**

## Installation

1. Clone the repository:
```bash
git clone [https://github.com/wichru/project-conversation-history]
cd project-conversation-history
```

2. Install dependencies:
```bash
bundle install
```

3. Create database:
```bash
rails db:create db:migrate db:seed
```

## Run the application:
```bash
bin/dev
```
Application will be running on http://localhost:3000

### Tests && code coverage

```sh
$ cd project-conversation-history
$ rspec spec
```

### Demo app

You can find a demo app deployed on Fly.io [here](https://project-conversation-history.fly.dev/)
