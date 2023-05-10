# ActiveAdminBasicAuthorizationAdapter

This repository is for now in test mode, should maybe implement more tests and be updated
with the last updates of ActiveADmin::AuthorizationAdapter

## Installation

Add the following line to your gemfile

```ruby
gem 'active_admin_basic_authorization_adapter'
```

Then

```ruby
bundle install
```

OR

```sh
gem install active_admin_basic_authorization_adapter
```

## Configuration

To create the default authorization file, run

```ruby
rails generate default_basic_admin_authorization
```

Then add to your active admin initializer:

```ruby
# IN config/initializers/active_admin
config.authorization_adapter = ActiveAdminBasicAuthorizationAdapter
```

## Authorizations

Active Admin authorization adapter has 4 methods for the CRUD:

```ruby
:read, :create, :update, :destroy.
```

These authorizations handle the following default active admin controller methods:

```
read: #index, #show;
create: #new, #create;
update: #edit, #update;
destroy: #destroy
```

You can also define new methods for your member_actions with the following code:

```ruby
module ActiveAdmin
  module Authorizations
    class MyAdminPageOrModelAuthorization < DefaultAuthorization
      # ...

      def my_member_action
        # YOUR AUTHORIZATION LOGIC HERE
      end
    end
  end
end
```

## Authorizations generator

```ruby
rails generate basic_admin_authorization Thing
```

Will create the following file
app/admin/authorizations/thing_authorization.rb

With the following code:

```ruby
# frozen_string_literal: true

# require_relative './default_authorization'

module ActiveAdmin
  module Authorizations
    class MyAdminPageOrModelAuthorization < DefaultAuthorization
      def read
        false
      end

      def create
        false
      end

      def update
        false
      end

      def destroy
        false
      end

      # Add your custom member_actions here
    end
  end
end

```

You can also pass the admin_type option:

```ruby
rails generate basic_admin_authorization Thing --admin_type true
```

```ruby
# frozen_string_literal: true
# require_relative './default_authorization'

module ActiveAdmin
  module Authorizations
    class MyAdminPageOrModelAuthorization < DefaultAuthorization
      def read
        true
      end

      def create
        true
      end

      def update
        true
      end

      def destroy
        true
      end

      # Add your custom member_actions here
    end
  end
end

```

# WARNING:

If ever you see the following error

```ruby
<module:Authorizations>: uninitialized constant ActiveAdmin::Authorizations::DefaultAuthorization (NameError)
```

You might need to uncomment the following line at the top of THE FILE WHERE THE ERROR WAS THROWED (usually the first file in admin/authorizations).

```ruby
# require 'admin/authorizations/default_authorization'
```

There is a problem of reading order file. If ever you have any better solution, feel free to make a pull request.

## ActiveAdmin comments authorization specific usecase

If you want to use active admin comments, follow these steps: 
Hint: you will have to 

First, you'll need to create the following file: 

```app/admin/authorizations/active_admin/comment_authorization.rb```

Then, paste the following code inside this file:
```ruby
# frozen_string_literal: true

# require_relative '../default_authorization'

module ActiveAdmin
  module Authorizations
    class CommentAuthorization < DefaultAuthorization
      def read
        false
      end

      def create
        false
      end

      def update
        false
      end

      def destroy
        false
      end
    end
  end
end

```

Finally, change this code with your authorization logic inside the methods.

Most of the time, this will be the first read file from the admin authorizations (cf the WARNING section)
If it is, you will need to uncomment this line ```# require_relative '../default_authorization'```
