.PHONY: update build install

update: npm_install build install

npm_install:
	npm install

build:
	npx vsce package --out ../compiled/robenkleene.vsix
