# ActiveAdminBasicAuthorizationAdapter

This repository is for now in test mode, should maybe implement more tests and be updated
with the last updates of ActiveADmin::AuthorizationAdapter

## Installation

```sh
gem install active_admin_basic_authorization_adapter
```

OR

add the following line to your gemfile

```ruby
gem 'active_admin_basic_authorization_adapter'
```

To create the default authorization policy, run

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
:read, :create, :update, :delete.
```

These authorizations handle the following default active admin controller methods:

```
read: #index, #show;
create: #new, #create;
update: #edit, #update;
delete: #destroy
```

You can also define new methods for you member_actions with the following code:

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

```ruby
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

AND with the admin_type option:

```ruby
rails generate basic_admin_authorization Thing --admin_type true
```

```ruby
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
