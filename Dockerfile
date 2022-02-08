FROM cypress/included:9.4.1

ENV LANG=en_GB.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -qq && \
    apt-get install -qq gnupg2 && \
    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    source /etc/profile.d/rvm.sh && \
    rvm install 3.0.3 && \
    rvm use 3.0.3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN source /etc/profile.d/rvm.sh && \
    rvm use 3.0.3 && \
    gem install bundler -v '2.2.32' && \
    gem install rerun

COPY . /app

RUN cd /app && source /etc/profile.d/rvm.sh && rvm use 3.0.3 && bundle install && npm install cypress-failed-log@2.9.2

RUN rm -rf /app

ENTRYPOINT bash -c 'cd /app && source /etc/profile.d/rvm.sh && rvm use 3.0.3 && bundle exec sidekiq -r ./sidekiq/config.rb'