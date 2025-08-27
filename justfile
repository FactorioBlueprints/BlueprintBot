set dotenv-filename := ".envrc"

group_id_with_slashes := "com/demod"

import ".just/console.just"
import ".just/maven.just"
import ".just/git.just"
import ".just/git-test.just"
import ".just/fbsr.just"

# `just --list--unsorted`
default:
    @just --list --unsorted

# `mise install`
mise:
    mise install --quiet
    mise current

# `git fetch` in each submodule.
fetch-submodules:
    git submodule foreach 'git fetch --all --prune --jobs=16'

# `git push` in each submodule.
push:
    git submodule foreach 'git push origin HEAD'
    git push

open-submodule-tabs:
    git submodule foreach 'open -a iTerm .'

# clean (maven and git)
@clean: _clean-git _clean-maven _clean-m2

markdownlint:
    markdownlint --config .markdownlint.jsonc  --fix .

# Run all formatting tools for pre-commit
precommit: mvn
    uv tool run pre-commit run

# Override this with a command called `woof` which notifies you in whatever ways you prefer.
# My `woof` command uses `echo`, `say`, and sends a Pushover notification.
echo_command := env('ECHO_COMMAND', "echo")
