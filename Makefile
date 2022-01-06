.PHONY: format
format:
	@bundle exec rubocop --auto-correct || true