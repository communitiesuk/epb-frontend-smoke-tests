.PHONY: test
test:
	@bundle exec rspec spec --format documentation

.PHONY: format
format:
	@bundle exec rubocop --auto-correct || true