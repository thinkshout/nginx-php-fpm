FROM richarvey/nginx-php-fpm:1.9.1

LABEL maintainer="Maria Fisher <maria.fisher@thinkshout.com>"

# Bring in our nginx customizations
COPY conf/nginx-site.conf /etc/nginx/sites-available/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# TS Customizations
RUN apk add --no-cache mysql-client \
    su-exec \
    rsync
RUN export PATH="~/.composer/vendor/bin:$PATH" && \
    echo "sendmail_path=`which true`"  >> ${php_vars} \
    && echo "memory_limit = 256M"  >> ${php_vars} \
    # Get WP CLI
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    # Get Drush launcher
    && wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.5.1/drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    # Get Terminus
    && mkdir -p /var/www/.composer \
    && cd /var/www/.composer \
    && curl -O https://raw.githubusercontent.com/pantheon-systems/terminus-installer/master/builds/installer.phar \
    && php installer.phar install \
    # Get Drupal console
    && curl https://drupalconsole.com/installer -L -o drupal.phar \
    && chmod +x drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal
# Get java for Behat/selenium/chromedriver tests
RUN apk add --no-cache openjdk8-jre \
    patch

# Add an extension for commerce.
RUN docker-php-ext-install bcmath

# Get Google Chrome (well, chromium)
RUN apk add -U --no-cache --allow-untrusted chromium

# Add packages and settings for screener.io automated visual regression testing
RUN apk add --update jq
RUN apk add -U --no-cache nghttp2-dev nodejs nodejs-npm
RUN npm config set unsafe-perm=true
ENV NODE_PATH /usr/lib/node_modules
RUN npm install dotenv@latest --global
RUN npm install screener-runner@latest --global
# End TS Customizations

