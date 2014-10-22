web: bundle exec thin start -p $PORT -e $RACK_ENV
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=4 bundle exec rake resque:work
