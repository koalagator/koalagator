[![Build Status](https://github.com/koalagator/koalagator/actions/workflows/test.yaml/badge.svg)](https://github.com/koalagator/koalagator/actions/workflows/test.yaml)
[![Maintainability](https://api.codeclimate.com/v1/badges/ebc339bb7a91acaafeba/maintainability)](https://codeclimate.com/github/koalagator/koalagator/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/koalagator/koalagator/badge.svg?branch=main)](https://coveralls.io/github/koalagator/koalagator?branch=main)


Koalagator
=========

About
-----

Koalagator is an open source community calendaring platform.
The project is an community fork of the community developed project Calagator.
Koalagator is run by a wholly new core team, contributors welcome.

Thank you to everyone who contributed to the original calagator project (you're still listed here as contributors).
We appreciate the encouragment from the ruby community for us to undertaking a revivial of this project.
Koalagator is a hard community fork of calagator. We've upgraded the project from Rails 4.2 to Rails 7.1 as part of this revival.

About the revival
-----------------

The calagator project has much to celebrate in creating a vibrant community calander platform.
In the late 2010's, the calagator project became effectivley inactive. An out-of-date rails version (v4.2) as well as a range of build issues and development bugs made it difficult to start new projects or receive support.

Over the last year our new team, based in Australia, have been gradually slaying dragons to undertake the unenviable task of upgrading the calagator code base across multiple major Rails versions. We are pleased to announce that in March 2024 we bought the project up to the current latest version of ruby and rails. 

With the calagator core team inactive and not open to processing Pull Requests, in communication with them they said they encouraged community forks. 

In March 2024 we are now releasing koalagator as a community fork of calagator.

The koalagator project will seek to improve on the calendar platform taking into account the needs community ecosystems in the 2020's.

We'd love you to join us on the journey.

Ps. We're still settling in so there may still be references to calagator while we're still setting up

Why
---

By releasing this code under a GNU Affero General Public License (AGPL), we hope to empower other people so they can better organize and participate in more events that support free sharing of information, open society, and involved citizenry.

Understanding the code base
---------------------------
Koalagator is an open source community-ecosystem calendar platform.

Community members can quickly see, what's on today, tomorrow and in the coming weeks.
They can search events by tag and even subscribe calendar feed for any tags they want to follow more closely.

Technically speaking this project is a Rails Engine (but please dont let this scare you away).

To start your own koalagator instance, you install the koalagator gem locally and run 'koalagtor new projectname'.
Going forward your local instance includes koalagator in the gemfile, and benefits from new features by upgrading the gemfile when you see fit.

We encourage you to contribute to Koalagator itself, which can benefit all current and future community-ecosystem running on kolagator. Cloning this repo, lets you work on the Koalagator gem itself. 

#### Overview of development workflows

The development workflow is; clone this repo, bundle, migrate, run seeds with demo data, bin/rails server

To run tests: run main test suite, run appraisal test suite

To upgrade the gem: bump gem version, build gem locally, run koalagator new, bundle & test.

To publish to rubygems: [RELEASE.md](https://github.com/koalagator/koalagator/blob/main/RELEASE.md)

Read [DEVELOPMENT.md](http://github.com/koalagator/koalagator/blob/main/DEVELOPMENT.md) for details instructions.

For specific guidance on upgrading Rails, read [RAILS_UPGRADES.md](http://github.com/koalagator/koalagator/blob/main/RAILS_UPGRADES.md).

## A note on Koalagtor vs Calagator

As a community fork of calagator, we've renamed most of the superficial/branding parts of the app as kalagator.
Within the codebase the term calagator is still in common use. Renaming everything is an ongoing process, expect some references to calagator herein. Join us if you'd like this switch over to occur quicker.

Setup an Instance
-----------------

Read [SETUP_AN_INSTANCE.md](https://github.com/koalagator/koalagator/blob/main/SETUP_AN_INSTANCE.md) file for details instructions on setting up your own instance of Koalagator for your own local community ecosystem.

Contributing
------------

Bug fixes and features are welcomed. Please fork the source code and submit a pull request: <http://github.com/koalagator/koalagator/tree/main>

When you make a pull request, make sure to add your name to the list of contributors in [CONTRIBUTORS.md](http://github.com/koalagator/koalagator/blob/main/CONTRIBUTORS.md).

All Koalagator contributors are expected to read and follow our [Code of Conduct](https://github.com/koalagator/koalagator/blob/main/CODE_OF_CONDUCT.md).

Contributors
------------

This free, open source software was made possible by a group of volunteers that put many hours of hard work into it. See the [CONTRIBUTORS.md](http://github.com/koalagator/koalagator/blob/main/CONTRIBUTORS.md) file for details.


License
-------

This program is provided under GNU Affero General Public License (AGPL), read the [LICENSE.md](http://github.com/koalagator/koalagator/blob/main/LICENSE.md) file for details.


Copyright
---------

Copyright (c) 2024 Koalagator
