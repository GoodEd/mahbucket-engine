## Installation
Add this line to your application's Gemfile:

```ruby
gem 'mahbucket'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mahbucket
```

## Configuration
`config/initializers/mahbucket.rb`

```ruby
require 'mahbucket'

authorize_request = Proc.new do |request|
    # Define how to authroize a request   
end

Mahbucket.setup do |config|
  config.authorize_request = authorize_request
  config.s3_credentials = {
    region: <region>
    bucket: <bucket name>,
    access_key_id: <access key id>
    secret_access_key: <secret access key>
  }
end
```