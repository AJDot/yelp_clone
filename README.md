# Yelp (Clone)

This is an assignment from [Launch School](https://launchschool.com/) to practice test driven development (TDD). It provides the minimal functionality of the popular site, Yelp. i.e. users can sign in and create/view business/reviews.

p.s. This is the first time I've used Sass as well.

* Ruby version 2.4.0
* Rails version 5.1.4

* Database creation
    I use PostgreSQL for my development/test database. I used this for my `config/database.yml` file. If you are wanting to run this app locally, create this file and change the username and password to your own.
    ```yml
    development:
      adapter: postgresql
      encoding: unicode
      database: yelp_clone_development
      pool: 5
      username: ********
      password: ********

    test:
      adapter: postgresql
      encoding: unicode
      database: yelp_clone_test
      pool: 5
      username: ********
      password: ********
    ```

* Database initialization
  I have seeds for the database. If you want some pre-populated data then run `rake db:reset` (instead of `rake db:migrate`) to create the seed data before starting the rails server.

* How to run the test suite
    I'm using rspec so just execute `rspec` to run all the tests.
