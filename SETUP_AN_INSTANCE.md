# Setup an Instance

Koalagator is distributed as a [Rails engine](http://guides.rubyonrails.org/engines.html), which is a type of Ruby gem that can be "mounted" inside of a Rails application to add functionality. In this document, we'll refer to the app that Koalagator is mounted in as the *host application*.

## Requirements

Koalagator requires Ruby >= 2.6.0, and a host application built on Rails 5 or newer.

## Running a site based on Koalagator

If you're looking to build your own community calendar using Koalagator, follow these instructions. If you're aiming to contribute code to Koalagator itself, see the instructions in [DEVELOPMENT.md](https://github.com/Koalagator/Koalagator/blob/main/DEVELOPMENT.md).

### Getting Started

First, install the `koalagator` gem:

    gem install koalagator
    
You can then use the `koalagator` command to generate a new Rails application with Koalagator installed:

    koalagator new my_great_calendar
    cd my_great_calendar

You should now be able to start your calendar in development mode with:

    bin/rails server

If all went according to plan, you should be able to see your calendar at: [http://localhost:3000](http://localhost:3000).

To stop the server, press `CTRL-C`.

## A note on Koalagtor vs Calagator

As a community fork of calagator, we've renamed most of the superficial/branding parts of the app as kalagator.
Within the codebase the term calagator is still in common use. Renaming everything is an ongoing process, expect some references to calagator herein. Join us if you'd like this switch over to occur quicker.

## Configuration

Koalagator's settings can be configured by editing these files in your host application:

* `config/initializers/01_calagator.rb`
* `config/initializers/02_geokit.rb`
* `config/initializers/03_recaptcha.rb`
* `config/initializers/04_devise.rb`

Please see these files for more details.

### Devise Authentication
Devise can be enabled in the `01_calagator.rb` initializer.
You will also want to configure Koalagator's admin username, email, and password; this will
be used to automatically create the initial admin user.

Alternately, you could create an admin user in the rails console like this:
```
User.create(name: "admin", email: "admin@example.com", password: "insecure", password_confirmation: "insecure", admin: true)
```

If enabled, you must also configure your mail settings in `config/environments/production.rb`.
If it's not already there, please add the following:
```rb
config.action_mailer.default_url_options = { host: 'example.com' }
```
Replace the example host with your own.

Once Devise has been enabled, users will be required to sign in to create and modify events, venues etc.

You will also want to set up [Action Mailer](https://guides.rubyonrails.org/action_mailer_basics.html) for password reset functionality.

### Time Zone

It's important to make sure your time zone is properly configured in `config/application.rb`. Koalagator relies heavily on this setting when displaying event times.

### API Keys

Koalagator uses API keys to communicate with certain external services.

* Google Maps: To use Google's geocoder, and to use Google to display maps, you must get an API key.  See `config/initializers/01_calagator.rb` and `config/initializers/02_geokit.rb` for details.

### Search engine

You can specify the search engine to use in `config/initializers/01_calagator.rb`:

#### SQL

This is the default search engine which uses SQL queries. This option requires no additional setup, dependencies, or service. It does not provide relevance-based sorting. It does provide substring matches.

## Customization

There are two places you'll want to customize right away. Both are *.html.erb files you'll need to create.

`views/koalagator/site/_description.html.erb` is the description in the sidebar on the home page of your calendar.

`views/koalagator/site/about.html.erb` is the about page linked to from the home page. The existing sidebar has links to anchors called `find_local_events`, `share_local_events`, and `get_involved` as suggested sections of the About page.

<!--
**TODO: engine CSS and view overrides, variables.scss, config.scss(?)**
-->

Feedback wanted
---------------

Is there something wrong, unclear, or outdated in this documentation? Please get in touch so we can make it better. If you can contribute improved text, we'd really appreciate it.
