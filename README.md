# Courier 

Ruby gem for interacting with the [Courier] API.

[Courier]: https://courier.thoughtbot.com

[![Build Status](https://circleci.com/gh/thoughtbot/courier-gem.svg?style=shield&circle-token=b09feb2f03dbc8fa7aa16d1977da3771b47c675c)](https://circleci.com/gh/thoughtbot/courier-gem)
[![Code Climate](https://codeclimate.com/repos/572a0503b781dc24b0000564/badges/db6744d185fd35deb8da/gpa.svg)](https://codeclimate.com/repos/572a0503b781dc24b0000564/feed)

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

Instantiate a Courier instance with your app's API token and an environment:

```ruby
courier = Courier::Client.new(api_token: "[YOUR_API_TOKEN]", environment: :development)
```

For the environment choose `:development` if you're sending notifications to a development build of an app. If you're sending notifications to an app signed with a distribution certificate (TestFlight, HockeyApp, AppStore, etc) use `:production`.

Broadcast a notification to a channel:

```ruby
broadcast = courier.broadcast("[CHANNEL_NAME]", alert: "Hello from Courier")

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
