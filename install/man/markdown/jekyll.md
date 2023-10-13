%

# `jekyll`

## Common Configurations

Only recent:

	bundle exec jekyll serve --watch --drafts --config _config_local.yml --limit_posts 5

Everything:

	bundle exec jekyll serve --watch --drafts --config _config_local.yml

Everything No Configuration:

	bundle exec jekyll serve --watch --drafts

## Normal

	jekyll build --watch
	jekyll serve

## With Drafts

	jekyll build --watch --drafts
	jekyll serve --drafts

## With `github-pages` Gem

	bundle exec jekyll serve
	bundle exec jekyll build --watch

### Include Drafts

	bundle exec jekyll serve --drafts
	bundle exec jekyll build --watch --drafts

## `serve` Flags

- `-P` / `--port`: Specify a port

## Generating Faster

### Local `_config.yml`

	--config _config_local.yml

This is useful to specify a local theme that doesn't need to get fetched from the server first:

	# theme: minima
	# remote_theme: robenkleene/cyclist
	theme: cyclist

### Limit posts

	--limit_posts 5

## Overriding Themes

Overriding themes works simply: To override any file from a theme (including theme gems), just put a file to override the default in the site as same relative path from the theme root. For example, to override `assets/main.scss` in the theme, add that same path to the site.

`.scss` files have a major caveat here: `.scss` in the assets folder will only be processed if the file starts with two lines of `---`. If those two lines don't exist, the `.scss` file will simply be copied to the assets directory, without being processed, and without overriding the default `.scss` file.
