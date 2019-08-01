[![CircleCI](https://circleci.com/gh/rubygarage/inquisition/tree/develop.svg?style=shield)](https://circleci.com/gh/rubygarage/inquisition/tree/develop)
[![Maintainability](https://api.codeclimate.com/v1/badges/782f08cb5c7c04eeaf04/maintainability)](https://codeclimate.com/github/rubygarage/inquisition/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/782f08cb5c7c04eeaf04/test_coverage)](https://codeclimate.com/github/rubygarage/inquisition/test_coverage)
[![Inline docs](http://inch-ci.org/github/rubygarage/inquisition.svg?branch=develop)](http://inch-ci.org/github/rubygarage/inquisition)

## What Inquisition gem is?
Ruby and Ruby on Rails have plenty of tools that help you analyze your codebase quality. However, setting up and configuring every single tool takes too much time. We at RubyGarage decided to save developers' time and create a gem that encompasses all the code analysis tools we use on a daily basis as well as configuration files for each tool and Rake tasks for launching these tools:

* Brakeman - a static analysis security vulnerability scanner for Ruby on Rails applications
* Bullet - a gem that finds and kills N+1 queries and unused eager loading
* Bundler-audit - a patch-level verification for Bundler
* Fasterer - a gem that helps Rubies go faster
* RailRoady - a gem that helps you generate Rails 3/4/5 model (ActiveRecord, Mongoid, Datamapper) and controller UML diagrams
* Rails ERD - a gem that generates Entity-Relationship Diagrams for Rails applications
* Rails_best_practices - a code metric tool for rails projects
* Reek - a code smell detector
* RuboCop - a Ruby static code analyzer and code formatter

The tools are configured for displaying output to the console in a single format which results in better readability and no need to switch between the tools.

The complete list of the tools and links to official repositories can be found in [inquisition.gemspec](https://github.com/rubygarage/inquisition/blob/develop/inquisition.gemspec) file.

If you'd like to check the information regarding each tool, feel free to follow the links.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inquisition', github: 'rubygarage/inquisition', group: %w(development test)
```

Then execute the following commands:

```bash
$ bundle
$ rails inquisition:install
```

## How to use the Inquisition gem?
By executing the command below, you'll get a list of commands that will allow you to launch either all the tools at a time or launch every single tool separately.

```bash
$ rails --tasks inquisition
```
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
***
<a href="https://rubygarage.org/"><img src="https://rubygarage.s3.amazonaws.com/assets/assets/rg_color_logo_horizontal-919afc51a81d2e40cb6a0b43ee832e3fcd49669d06785156d2d16fd0d799f89e.png" alt="RubyGarage Logo" width="415" height="128"></a>

RubyGarage is a leading software development and consulting company in Eastern Europe. Our main expertise includes Ruby and Ruby on Rails, but we successfully employ other technologies to deliver the best results to our clients. [Check out our portfolio](https://rubygarage.org/portfolio) for even more exciting works!
