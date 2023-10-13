# `gh`

## Browse

- `gh browse`: Open in repo browser

## Create

- `gh repo create`: Create a new repo by following instructions

## Pull Requests

- `BROWSER= gh pr view --web`: View on web
- `gh pr create`: Create PR
- `gh pr merge`: Merge PR (while on the current branch to be merged)
- `gh pr checks`: Show status checks

### Workflow

Create a pull request into `master`:

	gh pr create

Create a pull request into a different branch:

	gh pr create -B <branch name>

Open pull request creation page in the browser:

	gh pr create --web

