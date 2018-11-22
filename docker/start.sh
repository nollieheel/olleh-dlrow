#!/bin/bash
#
# A simple task starter for Puma and Sidekiq.
# This script should ONLY be used as a task starter in a Docker container.
#
# Depends on docker image: starefossen/ruby-node:2-8
#
# Usage:
# Start the container with CMD:
#    /bin/bash docker/start.sh
#
# To also run Sidekiq, start the container with CMD:
#    /bin/bash docker/start.sh sidekiq
#
# Any other argument will be ignored.


if [ "$1" = "sidekiq" ]; then
    echo start script running Sidekiq server

    for (( x=SIDEKIQ_WORKERS ; x > 0 ; x-- )); do
        /usr/local/bin/bundle exec sidekiq \
            --index "$x" --environment "$RUBY_ENV" \
            --config "$SIDEKIQ_CONF" \
            --pidfile "tmp/pids/sidekiq-${x}.pid" \
            --logfile log/sidekiq.log --daemon
    done
fi

echo start script running Puma server

/usr/local/bin/bundle exec puma -C "$PUMA_CONF"
