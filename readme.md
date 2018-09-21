# The Globe Church

[![Build Status](https://travis-ci.org/theglobechurch/tgc.svg?branch=master)](https://travis-ci.org/theglobechurch/tgc)

## Setup

- `git clone`
- `npm install && npm run dev`

### With Vagrant…

- `vagrant up`
- `vagrant ssh`
- `cd /srv/tgc`
- `bundle exec rails db:migrate && bundle exec rails db:seed`
- `./run-dev`

### With Docker…

- `docker-compose run web rake db:create`
- `docker-compose run web rake db:migrate`
- `docker-compose run web rake db:seed`
- `docker-compose up`

## PSequel

If you want to talk to the database via PSequel you'll need these steps

- `vagrant ssh-config`
- `host: localhost`
- `user: postgres`
- `db: globe_development`
- `ssh host: globe.local`
- `ssh port: 22`
- `ssh user: ubuntu`
- `id file :` see vagrant ssh-config

You may need to access add this ssh connection to the known hosts via command line first (Ref: https://github.com/psequel/psequel/issues/128)

`ssh ubuntu@globe.local -vNL 5432:localhost:5432 -p 22 -i /path/to/.vagrant/machines/project/virtualbox/private_key -o ExitOnForwardFailure=yes -o ConnectTimeout=30 -o TCPKeepAlive=no -o ServerAliveInterval=10`

## Other bits…

### Banner images

Generate with `bash bin/resize path/to/image.jpg`
