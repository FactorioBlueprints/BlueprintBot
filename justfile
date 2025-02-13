set shell := ["bash", "-O", "globstar", "-c"]
set dotenv-filename := ".envrc"

group_id_with_slashes := "com/demod"

import ".just/console.just"
import ".just/maven.just"
import ".just/git.just"
import ".just/git-rebase.just"
import ".just/git-test.just"

# `just -l -u`
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
push-submodules:
    git submodule foreach 'git push origin HEAD'

# clean (maven and git)
@clean: _clean-git _clean-maven _clean-m2

echo_command := env('ECHO_COMMAND', "echo")
