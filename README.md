# Sourcery (API)

### About This

Tracking the supply chain of agricultural product is a common challenge. How do
you know where you coffee *really* came from? Is your apple truly from a
sustainable farm? This app addresses these problems by adding visibility to the supply chain process by allowing users to add, update, and
read transactions on the Ethereum blockchain.

This Rails Api  will provide our [React front end](https://github.com/tmikeschu/sourcery-client) with the information it needs (ethereum addresses) to query our  [smart-contract ecosystem](https://github.com/ethanbennett/sourcery) on the Ethereum blockchain.  It will also store information that is not blockchain pertinent about the goods, transactions, and checkpoints we'll be dealing with such as (name, price, checkpoint, &c).

We are just getting started on this project. Eventually, users will be able to
visit the root page and view a list of items and their respective supply chain
paths.

Future iteration plans include the ability to add goods/products and register
change of possession (e.g., between producer and transport).


### About Us

We are a group of four [Turing School](https://www.turing.io/) students, and this is our capstone
project for the back-end engineering program. You can learn more about our
development process at these links: [DTR (team expectations)](https://gist.github.com/tmikeschu/1a37eef7724f06421d8bca19fd8be8ad), [stand-ups](https://gist.github.com/tmikeschu/14555f11f0d24d7c09749519c7b04337), [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/1996565).
And more about us at these ones: [Nick](https://github.com/ski-climb), [David](https://github.com/DavidKnott), [Ethan](https://github.com/ethanbennett), [Mike](https://github.com/tmikeschu).

### Getting Started

```rails api
git clone git@github.com:DavidKnott/sourcery-api.git
cd sourcery-api/

// install dependencies
bundle

// create db and migrate
rake db:{create,migrate}

// run the tests
rspec

// start the server
rails s
```

If using this with the [client app](https://github.com/tmikeschu/sourcery-client), be sure to run these steps as well for testing:

```
rake db:test:prepare
RAILS_ENV=test rake db:seed
rails -s -e test -p 9000
```
