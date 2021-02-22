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
Rails and many other things stripped out. There's a basic database that
is there mostly because the application logic includes bits that rely on
persisted data.

Recital uses type checking with Sorbet, and that is included here because it is
otherwise too confusing to tell the difference between objects that are internal
vs retrieved from an external provider. Sorbet is both gradual and optional -
you do not need to work with it at all for this assignment, and Sorbet changes
will not be part of our marking of your solution.

### Debugging in Ruby

If you'd like line-by-line debugging, you can drop into a debug session in the
command line by placing `binding.pry` as a line of code wherever your want. This
works as a normal line of code, so you can use conditionals to start a debug
session only in some situations. See the links below for commands to use in this
interface.

You can also append a filename and line number to your rspec command to run
only that test. e.g. `bundle exec rspec
spec/jobs/process_email_webhook_job_spec.rb:18`. When a test fails, rspec
gives you this command format for the specific failure at the bottom of its output.

**These two tricks combine well: you can put `binding.pry` in the code, and then
run only the failing rspec test, which will immediately drop you into a debug
session in the failing situation.**

### Links

Some links that may be helpful, should you want them:

- [Debug commands for binding.pry](https://github.com/deivid-rodriguez/pry-byebug#commands)
- [Basic intro to database access with
  ActiveRecord](https://www.devdungeon.com/content/ruby-activerecord-without-rails-tutorial)
- [Full ActiveRecord
  docs](https://guides.rubyonrails.org/active_record_basics.html)
- [Sorbet docs](https://sorbet.org/docs/sigs)

## About the Code

- `assignment.rb` runs a simulation of how this code would be called. Each
  command it runs would normally be executed as a result of an external call,
  such as a webhook or queue notification.
- `spec/` contains unit tests.
  - `spec/factories.rb` contains elements to construct fake data for testing.
    **Read this file for an example of the contract scan data format that you
    will be interpreting as part of the assessment.**
- `jobs/` are the background jobs that are executed by a background worker (in
  Recital, that's Sidekiq)
  - `jobs/process_email_webhook_job.rb` is, in the real app, a webhook that
    notifies the app that one of our users has received a new email.
  - `jobs/process_contract_scan_result_job.rb` would be triggered after the
    attachment's contents have been successfully scanned.
- `models/` contains our model classes:
  - `models/contract_scan_result.rb` is the parsing of the result of scanning the
  contract.
  - `modesl/db.rb` contains the database-backed models that the code
    creates/reads.
- `services/` contains all the business logic. Directionally, all businesss
  logic is being migrated here - so, in future, files in `jobs/` will just be
  thin wrappers around services.
  - `services/create_attachment_scan_service.rb` takes an attachment and would
    normally trigger the job. To avoid external dependencies, this file is
    empty/mocked out in this assessment code base.
  - `services/upload_email_attachments_for_scan_service.rb` takes in a message
    and triggers an attachment scan for each. Its name isn't quite right and
    should probably be renamed.
- `db/` contains the database setup and connection code. No modifications should
  be necessary to this folder

## Tasks

You will fix a bug, and then add a feature. These will be emailed to you at the start of your
scheduled time. The bugs and features are based on real tasks, though obviously are intentionally
simple to fit in a small time budget.

To give you some idea of what to expect:
- The bug is an issue where attachments are not scanned in a situation where they should.
- The feature is adopting a new version of the contract scan, which requires a
  slightly different way of evaluating the "best" result to select if there are
  more than one potential contract title results detected.

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

- You do _not_ need to do use or modify type checking or sorbet. Passing static
  type checking is not required or marked, and runtime type checking is
  explicitly disabled.
- You do _not_ need to implement for performance
- You do _not_ need a ruby solution. If you can't figure something out, write
  comment with pseudocode and we can talk through and/or write it together
  during the in-person assessment.

### Requirements

1. Meets task goals outlined in the assignment text (sent separately)
1. Passes tests (`bundle exec rspec`)
1. Passes rubocop (`bundle exec rubocop`)
1. Rubocop not manually disabled unless good justification is provided
1. Commited to git: one commit per bugfix, one commit for the feature
