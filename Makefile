.PHONY: all
default: all;

install:
	gem install bundler

clean:
	rm -rf vendor/
	rm -rf Berksfile.lock
	rm -rf Gemfile.lock

bundle:
	bundle check --path=vendor/bundle || bundle install --path=vendor/bundle --retry=3

kitchen:
	bundle exec kitchen test

style:
	bundle exec cookstyle -D

all: bundle kitchen
