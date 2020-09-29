# Docker image for Bitbucket CI Pipelines
> Created for and used by [Forsaken Expanse](https://forsakenexpanse.com/) Sci-Fi strategy game.

## About `bitbucket-ci-image:light`
Image Dockerfile is based on `atlassian/default-image:2` - [Atlassian CI image v2](https://hub.docker.com/r/atlassian/default-image).


## Motivation

Faster AWS lambda deployments using BitBucket pipelines.


## How does it compare to official `atlassian/default-image:2`?

1. Image comes with zip dependency installed which eliminates need for running `apt-get update && apt-get install -y zip` in `bitbucket-pipelines.yml`.
2. No Java dependencies


## Usage

### Using with Bitbucket pipeline 

Image is publicly hosted on docker hub so simply replace `bitbucket-pipelines.yml` image instruction with:
```
image: fullstackforger/ds-bitbucket-ci-image:light
```

Check official bitbucket [documentation](https://support.atlassian.com/bitbucket-cloud/docs/use-docker-images-as-build-environments/) for more details.


### Building locally

```
docker build -t bitbucket-ci-image:light .
```

You can run it with, eg:
```
docker run --name bitbucket_ci -it bitbucket-ci-image:light
```