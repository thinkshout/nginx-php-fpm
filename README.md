Very little configuration here -- we've added some post-run commands to the dockerfile, and overwritten some config for Drupal development.

Most configuraton is handled by the fork source at https://github.com/richarvey/nginx-php-fpm

To build locally from the Dockerfile run:
`docker build . -f Dockerfile`

More detailed info on how to push to Docker Hub found here: https://library.thinkshoutlabs.com/articles/how-publish-new-docker-image-docker-hub
