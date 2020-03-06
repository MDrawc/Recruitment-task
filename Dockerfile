FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /recruitment_task
WORKDIR /recruitment_task

COPY Gemfile /recruitment_task/Gemfile
COPY Gemfile.lock /recruitment_task/Gemfile.lock

RUN bundle install

COPY . /recruitment_task

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
