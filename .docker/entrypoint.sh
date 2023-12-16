bundle install

rm -f /app/tmp/pids/server.pid

rails db:create
rails db:seed

/app/bin/dev
