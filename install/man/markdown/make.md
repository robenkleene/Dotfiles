%

# Make

- `-d`: Print debug information
- `make --debug=b`: Run with basic debugging information

## Notes

### Parameters

In `Makefile`, it's really difficult to pass a parameter to a `make` command, e.g., `make force_deploy -f`. This is because in `make` parlance the arguments are all supposed to be files to run the command on, so it breaks the paradigm. Instead to solve this just make a separate shell script.

### Deleting Targets

- If `.DELETE_ON_ERROR` appears as a target, then if the build fails, the target will be deleted. The `-i` / `--ignore-errors` option can often be used to keep an executable.

## Tips

To suppress output of a command, precede it with an `@`:

    hello:
        @echo "hello world"

## Functions

    define test_message
        remote=$$(git config --get remote.origin.url | tr -d '\n'); \
        if [[ $${remote}  =~ (https://|git@)github.com[/:](.*) ]]; then \
          remote_subpath="$${BASH_REMATCH[2]}"; \
          remote_subpath=$${remote_subpath%.git}; \
          remote_url="https://github.com/$${remote_subpath}/pulls"; \
        else \
          echo ""; \
          exit 0; \
        fi; \
        echo "Hello $${remote_url} $1"
    endef

    run_test: test_start test_finish

    test_start:
        @$(call test_message,CISTARTED)

    test_finish:
        @$(call test_message,CIFINISHED)

## Variables

    NAME = robenkleene_macos
    ERGODOX_SRC = $(shell pwd)/ergodox_ez$(NAME)
    PLANCK_SRC = $(shell pwd)/planck$(NAME)
    ERGODOX_DIR = ../qmk_firmware/keyboards/ergodox_ez/keymaps/
    PLANCK_DIR = ../qmk_firmware/keyboards/planck/keymaps/
    ERGODOX_DEST = $(ERGODOX_DIR)$(NAME)
    PLANCK_DEST = $(PLANCK_DIR)$(NAME)

    link:
        ln -s $(ERGODOX_SRC) $(ERGODOX_DIR)
        ln -s $(PLANCK_SRC) $(PLANCK_DIR)

