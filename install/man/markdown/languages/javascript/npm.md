%

%

# `npm`

## Initializing

- `npm init`: Create a `package.json`

## Adding

- `npm add`: Add a package

### Other

- `-g`: install globally, e.g., `npm install -g markdown-toc`
- `npm install --save-dev` / `npm i -D`: Install for development only

## Uninstall

- `npm uninstall <package>`

## Updating

- `npm update`: Updates all dependencies to latest patch and minor releases (e.g., doesn't introduce breaking changes)

### Update Dependencies, Including Major Releases

This requires the separate `npm` module `npm-check-updates` (usually installed globally).

1. `ncu --upgrade` / `ncu -u`
2. `npm install`

### Clean Up

- `npm prune` is supposed to uninstall unused packages
    - Note that `npm` only ever includes one version of a dependency, so there are no old versions to clean up, just unused dependencies

## Global

- `npm list --global --depth=0`: List globally installed modules

## Running Actions

- `npm run`: List available scripts

## Info

- `npm view yarn`: View info

## Publishing

- `npm publish`: Publish a new version

## Notes

- `--save` is not necessary because that's the default now, `--no-save` used to be the default.

