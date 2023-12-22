bundle install

rm -f /app/tmp/pids/server.pid

rails db:create
rails db:migrate
rails db:seed

/app/bin/dev
