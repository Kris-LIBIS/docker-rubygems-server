FROM colstrom/ruby

COPY config.ru Gemfile lib/ /app/

WORKDIR /app
RUN apk-install ruby-dev gcc make musl-dev \
    && gem install io-console \
    && bundle install

ENV RUBYGEMS_STORAGE ${RUBYGEMS_STORAGE:-'/srv'}

VOLUME ${RUBYGEMS_STORAGE}

EXPOSE 3000

ENTRYPOINT ["reel-rack"]
