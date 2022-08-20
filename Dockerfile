FROM ruby:3.1.2

WORKDIR /usr/app

COPY ./ ./
RUN bundle

# CMD ["ruby", "history.rb"]
