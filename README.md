# Rails

A hello world rails app.

### config/master.key:

$ tail -1 notes > config/master.key

### .env.production:

export MESSAGE=whatever

## Deploy

$ bundle exec cap production linked_files:upload_files
$ bundle exec cap production deploy
