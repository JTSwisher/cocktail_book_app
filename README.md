# Cocktail Keeper

Cocktail Keeper allows users to create cocktail recipes and view recipes created by the community. Users can save their favorite recipes from the community to their accounts and provide an associated rating. 

## Demo

[CocktailBook: A Ruby on Rails App](https://youtu.be/_Lku7V-rI9U)

## Getting Started

These instructions will get a local copy of Cocktail Keeper up and running on your machine.

### Prerequisites

* [Ruby] (https://www.ruby-lang.org/en/)
* [Rails] (https://rubyonrails.org/)
* [PostgreSQL] (https://www.postgresql.org/)

## Installation

Fork and clone the [Repo] (https://github.com/JTSwisher/cocktail_book_app) to your local machine.

#### Backend
Change directories into Cocktail Keeper local directory. Run bundle install to install dependencies. Ensure PostgreSQL is running on your machine, create and migrate the database.
```
$cd cocktail_book_app
$bundle install
$rails db:create
$rails db:migrate
```
Run the following command to start your local server.
```
rails s
```

## Built With

* Ruby
* Rails
* PostgreSQL
* Bootstrap
* Omniauth

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Authors

[Jeff Swisher](https://github.com/JTSwisher)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
