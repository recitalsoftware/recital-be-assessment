# Recital Project

Hello, and thanks for your interest in joining Recital. We're excited to have others join our team,
and aim to build a truly excellent group. We've put significant thought into this assessment because
we want to ensure we hire the best team while also being respectful to you and your time.

You should have received this code in advance, and you will receive the problem to solve by email
at the time of your choosing. You'll have 4 hours to complete it. We send the code in advance so
you can familiarize yourself with it, should you choose. The assignment will not require you to do
so, but working at Recital will not require you to immediately work on code you've never looked at
before, so our assessment doesn't require that either.

If you have any questions before, during, or after the assessment, please do not hesitate to reach
out to Brendan: brendan@recital.software. Brendan commits to responding immediately within his
normal working hours: M-F 13.00-21.00 CET
([convert to local time here](https://www.thetimezoneconverter.com/)).

## Build Setup

```bash
" requires a basic database with sqlite
$ brew install sqlite

# install dependencies
$ bundle install

# Run example scenario, if you'd like to inspect
$ bundle exec ruby assessment.rb

# Note that running the assessment will update the database, so if you want to
# refresh it:
$ rm db/sqlite.db && bundle exec ruby db/create.rb

# Or just reset it from git:
$ git checkout -- db/sqlite.db

# But probably tests are all you need:
$ bundle exec rspec

# Check if it this meets the lint and test requirements:
$ bundle exec rubocop && bundle exec rspec
```

## Product Description

Recital processes the emails that our users receive, scanning the attachment of
each to identify if they are a contract and, if so, which contract they are
about. This mini project is extracted from that setup. The jobs and so on are
roughly the same as our actual code base. Since these methods are usually called
by outside services, there is a single orchestrating file (`assignment.rb`) that
you can run directly to simulate how this code would work in real life.
Meanwhile, there are tests that more directly test behaviour, also mostly pulled
from Recital's backend project repository.

## About The Tech Stack

This tech stack is a simplified excerpt from the Recital Backend project, with
Rails, Sorbet, and many other things stripped out. There's a basic database that
is there mostly because the application logic includes bits that rely on
persisted data.

Some links that may be helpful, should you want them:

- [Basic intro to database access with
  ActiveRecord](https://www.devdungeon.com/content/ruby-activerecord-without-rails-tutorial)
- [Full ActiveRecord
  docs](https://guides.rubyonrails.org/active_record_basics.html)

## About the Code

- `assignment.rb` runs a simulation of how this code would be called. Each
  command it runs would normally be executed as a result of an external call,
  such as a webhook or queue notification.
- `spec/` contains unit tests.
- `jobs/` are the background jobs that are executed by a background worker (in
  Recital, that's Sidekiq)
  - `jobs/asdf.rb` file description
- `models/contract_scan_result.rb` is the parsing of the result of scanning the
  contract.
- `services/` business logic
  - `services/asdf.rb` file description

## Tasks

You will fix a bug, and then add a feature. These will be emailed to you at the start of your
scheduled time. The bugs and features are based on real tasks, though obviously are intentionally
simple to fit in a small time budget.

TODO: Add some info about what the tasks are

## Your Solution

Please compress (zip, tar) and email your solution back within 4 hours of your start time.
(Please don't spend 4 hours on this! It should only take you 1-2. At Recital, we value mental
health. Take care of yourself :) Take a break! Go for a walk! )

> If you have any problems with the compression/email approach, just upload to github/gitlab and
> send me the URL.

### Non-Requirements

We have tried our best so that you do not need to learn anything specifically for this. As much as
possible, everything you need to accomplish your tasks should already be in here. We hope that you
can simply modify existing code or copy/paste an existing block of code to accomplish anything you
need. However, that's probably impossible to do fully, so the following flexibility might be
helpful:

- You do _not_ need to implement for performance
- You do _not_ need to worry about tests. We are considering using them for a later version of this
  assessment, but for now they would be too much work.

### Requirements

1. Meets task goals outlined in the assignment text
1. Passes tests (`bundle exec rspec`)
1. Passes rubocop (`bundle exec rubocop .`)
1. Rubocop not manually disabled unless good justification is provided
1. Commited to git: one commit per bugfix, one commit for the feature
