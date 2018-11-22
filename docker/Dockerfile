FROM starefossen/ruby-node:2-8

# General vars, 
# Puma vars,
# Sidekiq vars
ENV WORK_DIR=/var/src/olleh-dlrow \
    RUBY_ENV=production \
    PUMA_CONF=config/puma.rb \
    PUMA_CONF_TEMPLATE=docker/puma.rb.template \
    PUMA_APP_NAME=olleh-dlrow \
    PUMA_BIND=tcp://0.0.0.0:3000 \
    PUMA_THREADS=4,16 \
    PUMA_WORKERS=0 \
    SIDEKIQ_CONF=config/sidekiq.yml \
    SIDEKIQ_WORKERS=2

EXPOSE 3000

RUN mkdir -p ${WORK_DIR}/log ${WORK_DIR}/tmp/pids ${WORK_DIR}/tmp/sockets ${WORK_DIR}/tmp/cache

WORKDIR $WORK_DIR

COPY . ./

# Resolve puma.rb,
# Create master.key
# Compile and deploy
RUN sed -e "s;\[WORK_DIR\];${WORK_DIR};g" \
        -e "s/\[RUBY_ENV\]/${RUBY_ENV}/g" \
        -e "s/\[PUMA_APP_NAME\]/${PUMA_APP_NAME}/g" \
        -e "s;\[PUMA_BIND\];${PUMA_BIND};g" \
        -e "s/\[PUMA_THREADS\]/${PUMA_THREADS}/g" \
        -e "s/\[PUMA_WORKERS\]/${PUMA_WORKERS}/g" \
        "$PUMA_CONF_TEMPLATE" > "$PUMA_CONF" \
    && tail -1 notes > config/master.key \
    && bundle install --path ./bundle --deployment \
    && bundle exec rake assets:precompile \
    && bundle exec rake db:migrate

CMD ["/bin/bash", "docker/start.sh"]
# To run Sidekiq also, use:
#CMD ["/bin/bash", "docker/start.sh", "sidekiq"]
