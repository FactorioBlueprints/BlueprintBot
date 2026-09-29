# set up `git-test`
setup-git-test:
    # Combined
    git test add --forget --test default                      'just clean _check-local-modifications mvn'
    git test add --forget --test checkstyle                   'just clean _check-local-modifications checkstyle'
    git test add --forget --test spotless-all                 'just clean _check-local-modifications spotless-all'
    # Individual
    # git test add --forget --test compile                      'just clean _check-local-modifications compile'
    # git test add --forget --test test                         'just clean _check-local-modifications test'
    # git test add --forget --test enforcer                     'just clean _check-local-modifications enforcer'
    # git test add --forget --test dependency                   'just clean _check-local-modifications dependency'
    # git test add --forget --test checkstyle-semantics         'just clean _check-local-modifications checkstyle-semantics'
    # git test add --forget --test checkstyle-formatting        'just clean _check-local-modifications checkstyle-formatting'
    # git test add --forget --test checkstyle-semantics-strict  'just clean _check-local-modifications checkstyle-semantics-strict'
    # git test add --forget --test checkstyle-formatting-strict 'just clean _check-local-modifications checkstyle-formatting-strict'
    # git test add --forget --test javadoc                      'just clean _check-local-modifications javadoc'
    # git test add --forget --test reproducible                 'just clean _check-local-modifications reproducible'
    # git test add --forget --test formats                      'just clean _check-local-modifications spotless --name formats'
    # git test add --forget --test prettier                     'just clean _check-local-modifications spotless --name prettier-java'
    # git test add --forget --test gjf                          'just clean _check-local-modifications spotless --name google-java-format'
    # git test add --forget --test sort-imports                 'just clean _check-local-modifications spotless --name java-sort-imports'
    # git test add --forget --test prettier-sort-imports        'just clean _check-local-modifications spotless --name prettier-java-sort-imports'
    # git test add --forget --test unused-imports               'just clean _check-local-modifications spotless --name java-unused-imports'
    # git test add --forget --test cleanthat                    'just clean _check-local-modifications spotless --name java-cleanthat'
    # git test add --forget --test pom                          'just clean _check-local-modifications spotless --name pom'
    # git test add --forget --test markdown                     'just clean _check-local-modifications spotless --name markdown'
    # git test add --forget --test json                         'just clean _check-local-modifications spotless --name json'
    # git test add --forget --test yaml                         'just clean _check-local-modifications spotless --name yaml'
    # git test add --forget --test sql                          'just clean _check-local-modifications spotless --name sql'

git_tests := env('GIT_TESTS', "default,checkstyle,spotless-all")
