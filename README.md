# README

* Ruby version:- 2.6.3
* Rails version:- 6.0.3.1
* Database:- MySQL
* Background job:- sidekiq

## Installation

```bash
$ bundle install
$ rails db:create & rails db:migrate & rails db:seed
```
and other necessary steps

## Mailer server(mailcatcher)
first install gem in your system
```bash
gem install mailcatcher
```

Run Mailcatcher Server
```bash
mailcatcher
```

## Background job(sidekiq)
Run sidekiq
```bash
sidekiq -q mailers
```
