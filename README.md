# Changelog Client

Send an event to a [Changelog](https://github.com/prezi/changelog) server

## Installation

Install it yourself as:

    $ gem install changelog_client

## Usage

A basic usage with the built-in severities:

	```ruby
	require 'changelog_client'
	client = ChangelogClient.new('my-server-address', 'my-port')
	client.send('This is the message', 'INFO', 'my-category')
	```

You can pass other severity as an int:

	```ruby
	client.send('This is the message', 8, 'my-category')
	```
On success, it returs `true` on failure, it returns `false`.

## Default built-in severities

You can pass any integer number as a severity parameter or any built-in severity string, which can be the following:

* 'INFO' - 1
* 'NOTIFICATION' - 2
* 'WARNING' - 3
* 'ERROR' - 4
* 'CRITICAL' - 5


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request