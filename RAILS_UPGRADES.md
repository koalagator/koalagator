# RAILS UPGRADES

Here is some advice on performing rails upgrades in Koalagator.

When working with Koalagator there are sort of fours layers to consider:
Building the main app, Testing the main app, Testing Appraisal alternatives, Testing the Gem project generation

1. Building the main app in the code repo

```
    bundle install
    rails server
```

3. Testing the main app in the code repo

    rails spec

4. Testing appraisal alternatives

```
    bundle exec appraisal install
    bundle exec appraisal rails spec
```

5. Testing the gem

# Update version.rb

```
    gem build koalagator.gemspec
    gem install koalagator
```

## Before the upgrade

- App builds
- Specs all passing
- Resolve any deprecation warnings that show in the specs or rails logs

## Update the Rails version in all the places

Update rails version in:

* Gemfile    # this: gem 'rails', '<here>'
* gemspec    # this: s.add_dependency 'rails', '~> <here>'
* rails_template

And the testing files:

* Appraisal   # this: appraise '<here>' in format 'rails_x_x'
* test.yaml   # here: test >  strategy > rails <here> in format 'rails_x_x'

```
    bundle update rails # then resolve any issues
    bundle install # then resolve any issues
```

Commit this.

## Run tests and resolve issues in tests

    rake spec

## Upgrade appraisal

## Update documentation

Review/update this wording in 'SETUP_AN_INSTANCE.md'.

    "Koalagator requires Ruby >= 2.6.0, and a host application built on Rails 5 or newer."












