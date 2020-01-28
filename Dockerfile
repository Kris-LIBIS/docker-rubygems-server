FROM ruby:2.6.5-buster
MAINTAINER Kris Dekeyser <kris.dekeyser@libis.be>

ENV RUBYGEMS_STORAGE /srv/gems
VOLUME ${RUBYGEMS_STORAGE}
EXPOSE 9292

COPY config.ru Gemfile /srv/app/
WORKDIR /srv/app

ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN bundle pack

COPY lib/ /srv/app/lib/

CMD ["bundle", "exec", "puma"]

