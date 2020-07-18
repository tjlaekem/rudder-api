.PHONY: install, lint, run

install:
	bundle install

lint:
	bundle exec rubocop app

run:
	bundle exec rails server -b 0.0.0.0 -p 80
