threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

plugin :tmp_restart

bind "unix://#{Rails.root}/tmp/sockets/puma.sock"

if ENV.fetch("RAILS_ENV") == "production"
  workers ENV.fetch("WEB_CONCURRENCY") { 2 }
  preload_app!

  stdout_redirect "#{Rails.root}/log/puma.stdout.log",
                  "#{Rails.root}/log/puma.stderr.log",
                  true
end