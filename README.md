Circle CI NAIS deployment orb
=============================

This is a [CircleCI orb](https://circleci.com/orbs/) that helps with building and pushing docker images and creating NAIS deployments.


## Documentation and usage

Documentation is over at [nais.io/doc](https://github.com/nais/doc/blob/master/content/deploy/circleci.md), where we try to collect the complete documentation for the NAIS platform. General usage examples can be sees under the "Usage Examples" section on the [orb registry](https://circleci.com/orbs/registry/orb/navikt/nais-deployment).


## Deploying new versions of the orb

Deployment is handled by CircleCI. All commits will create new development versions of the orb with the name of the branch, for example `navikt/nais-deployment@dev:branchname`.

For production versions, a new tag with a name that matches `/^[0-9]+\.[0-9]+\.[0-9]+$` like `1.0.1` will need to be created and pushed to Github.
