#!/bin/bash
#
# Depends on docker image: starefossen/ruby-node:2-8
#
# A simple task switcher between Puma and Sidekiq.
#
# To use Puma, start the container with COMMAND:
#    /bin/bash docker/start.sh puma
#
# To use Sidekiq, start the container with COMMAND:
#    /bin/bash docker/start.sh sidekiq


if [ "$1" = "sidekiq" ]; then
    task=sidekiq
else
    task=puma
fi

echo Task is "$task"

case "$task" in
    puma)
        /usr/local/bin/bundle exec puma -C "$PUMA_CONF"
        ;;
    sidekiq)
        for (( x=SIDEKIQ_WORKERS ; x > 0 ; x-- )); do
            /usr/local/bin/bundle exec sidekiq \
                --index "$x" --environment "$RUBY_ENV" \
                --config "$SIDEKIQ_CONF" \
                --pidfile "tmp/pids/sidekiq-${x}.pid" \
                --logfile log/sidekiq.log --daemon
        done
        tail -f log/sidekiq.log
        ;;
    *)
        echo No task specified
        exit 1
esac
