

### About This

Tracking the supply chain of agricultural product is a common challenge. How do
you know where you coffee *really* came from? Is your apple truly from a
sustainable farm? This app addresses these problems by adding visibility to the supply chain process by allowing users to add, update, and
read transactions on the Ethereum blockchain.

This Rails Api  will provide our [React front end]() with the information it needs (ethereum addresses) to query our  [smart-contract ecosystem]() on the Ethereum blockchain.  It will also store information that is not blockchain pertinent about the goods, transactions, and locations we'll be dealing with such as (name, price, location, &c).

We are just getting started on this project. Eventually, users will be able to
visit the root page and view a list of items and their respective supply chain
paths.

Future iteration plans include the ability to add goods/products and register
change of possession (e.g., between producer and transport).


### About Us

We are a group of four [Turing School]() students, and this is our capstone
project for the back-end engineering program. You can learn more about our
development process at these links: [DTR (team expectations)](), [stand-ups](), [Pivotal Tracker]().

### Getting Started

```rails api
git clone git@github.com:DavidKnott/sourcery-api.git
cd sourcery-api/

// install dependencies
bundle

// run the tests
rspec

// start the server
rails s
```