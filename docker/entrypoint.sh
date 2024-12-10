#!/bin/bash -e

#make sure this environments lockfile is used 
cp /config/Gemfile.lock /koalagator/Gemfile.lock
# (this might cause some chaos but if we want a bind-mounted 
#   RW working directory i cant think of a better solution)

# Init/Migrate DBs
bundle exec ./bin/rails db:migrate

exec "${@}"