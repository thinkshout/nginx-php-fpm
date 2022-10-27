Very little configuration here -- we've added some post-run commands to the dockerfile, and overwritten some config for Drupal development.

Most configuraton is handled by the fork source at https://github.com/richarvey/nginx-php-fpm

## Creating a new image for new php releases:
1. Create a new branch named for the new php version: aka php81, php80, etc.
2. Update the first line of the Dockerfile to pull in an image that supports your php version from the upstream repo at https://github.com/richarvey/nginx-php-fpm/releases. 
3. Commit that change to your branch, and try to build following the instructions at https://library.thinkshoutlabs.com/articles/how-publish-new-docker-image-docker-hub. If Docker doesn't start up correctly, there's probably some problem between the versions of php and the libraries we're pulling in in our Dockerfile. Debug that until the build succeeds.
4. Now push up the image to Dockerhub, using the instructions at https://library.thinkshoutlabs.com/articles/how-publish-new-docker-image-docker-hub

## Rebuilding the image for maintenance purposes:
To build locally from the Dockerfile run:
`docker build . -f Dockerfile`

More detailed info on how to push to Docker Hub found here: https://library.thinkshoutlabs.com/articles/how-publish-new-docker-image-docker-hub
