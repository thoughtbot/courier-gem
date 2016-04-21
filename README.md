# Courier

Ruby gem for interacting with the [Courier] API.

[Courier]: https://courier.thoughtbot.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'courier-notifications'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install courier-notifications

## Usage

Instantiate a Courier instance with your app's API token:

```ruby
courier = Courier::Client.new(api_token: "[YOUR_API_TOKEN]")
```

Broadcast a notification to a channel:

```ruby
broadcast = courier.broadcast("[CHANNEL_NAME]", alert: "Hello from Courier", badge: "1")

if broadcast.sent?
  # How do you handle success?
else
  # Interpret broadcast.status_code
end
```

Courier will send anything after the channel name argument as the push notification payload. See Apple's [remote notification payload documentation] for more information.

[remote notification payload documentation]: https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/TheNotificationPayload.html

Note that delivery of notifications is a “best effort”. It is possible for `broadcast.sent?` to return true, but no notification to be delivered.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Please see [CONTRIBUTING.md](/CONTRIBUTING.md).

## License

Courier is Copyright © 2016 thoughtbot. It is free software, and may be redistributed under the terms specified in the [LICENSE](/LICENSE) file.

## About thoughtbot

![thoughtbot](https://thoughtbot.com/logo.png)

Courier is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software! See [our other projects][community] or [hire us][hire] to design, develop, and grow your product.

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
