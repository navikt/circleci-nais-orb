# Circle CI NAIS deployment orb

This is a [CircleCI orb](https://circleci.com/orbs/) that helps with
building and pushing docker images and creating NAIS deployments.

## Usage

For general usage examples see the "Usage Examples" section on the [orb registry](https://circleci.com/orbs/registry/orb/navikt/nais-deployment).

### NAIS configuration

Set `image` in your NAIS configuration to `{{version}}` and `team` to `{{team}}`.

Example:

``` yaml
apiVersion: "nais.io/v1alpha1"
kind: "Application"
metadata:
  name: example-application
  namespace: default
  labels:
    team: {{team}}
spec:
  image: {{version}}
  port: 8080
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 200m
      memory: 256Mi
  liveness:
    path: "/status"
    port: 8080
  replicas:
    min: 1
    max: 2

```

### Docker hub authentication

In order for pushing to docker hub to work there are two ways to specify the authentication information.
If you are pushing to `navikt` you only need to specify the `NAIS deployment` [context](https://circleci.com/docs/2.0/contexts/).

For example:

``` yaml
version: 2.1
orbs:
  nais: 'navikt/nais-deployment:XYZ'
workflows:
  deploy-docker-and-nais:
    jobs:
      - nais/deploy:
          context: NAIS deployment
          repo: navikt/example-repo
          image: navikt/example-image
          github-app-id: 1337
          nais-template: nais.yaml
          environment: dev-fss
          team: awesome-team

```

If you need to deploy to other Docker hub organisations you need to set the [project environment variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project)
`DOCKER_LOGIN` and `DOCKER_PASSWORD`.

### Github deployment authentication

You should start out by reading the [Github deployment documentation](https://github.com/navikt/deployment) and follow the steps specified there.

Once you have an `RSA Private Key` for a Github application that has the rights to create deployments in your Github repo you need to encrypt it and store it in the repository in question:

``` shell
Usage: encrypt.sh path-to-file-with-key path-to-circleci-config-folder
Example: ./encrypt.sh ../../path-to-file-with-key ../my-repo/.circleci
```

Then command will return the two environment variables `OPENSSL_KEY` and `OPENSSL_IV` that you will need to set as [project environment variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project)
so that CircleCI can decrypt the private key.

### Example

See [example/](example) for an example of a fictitious application that uses this orb.

## Deploying new versions of the orb

Deployment is handled by CircleCI. All commits will create new development versions of the orb with the name of the branch, for example `navikt/nais-deployment@dev:master`.

For production versions a new tag with a name that matches `/^[0-9]+\.[0-9]+\.[0-9]+$` like `1.0.1` will need to be created and pushed to Github.
