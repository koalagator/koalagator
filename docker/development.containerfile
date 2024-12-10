#use ruby official base image
FROM docker.io/library/ruby:3.3.6-bookworm 

#install selenium for unit tests 
RUN apt-get update && apt-get install -y ruby-selenium-webdriver \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#add working dir
WORKDIR /config

#copy Gemfile and requires to working dir
COPY ./Gemfile ./koalagator.gemspec ./
COPY ./lib/calagator/version.rb ./lib/calagator/version.rb

#install dependencies
RUN bundle install --jobs 4 --retry 3

#install entrypoint script
COPY docker/entrypoint.sh ./

#set our app dir
WORKDIR /koalagator
VOLUME /koalagator

#default command
ENTRYPOINT ["/config/entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]