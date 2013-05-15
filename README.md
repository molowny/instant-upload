# Instant-Upload

Instant-upload is simply ajax upload for rails (with carrierwave).

## Installation

Add this to your Gemfile:

``` ruby
gem 'instant-upload'
```

and run `bundle install`.

Next, run:

``` bash
# Add the necessary migrations to your app's db/migrate directory
rake instant_upload:install:migrations
# And run any pending migrations
rake db:migrate
```

Add to your application.js
``` javascript
//= require instant_upload
```

and application.css
``` css
/*
 *= require instant_upload
 */
```

## Single column in model

```erb
<%= form_for @user do |f| %>
  <%= f.input :username %>
  <%= f.input :password %>
  <%= instant_upload_for @user, :avatar, version: :thumb %>
  <%= f.button :submit %>
<% end %>
```

``` ruby
class UsersController < ApplicationController
  # GET /users/new
  def new
    @user = User.new
    load_uploaded_files(@user, :avatar)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    return if handle_upload(@user, :avatar)

    respond_to do |format|
      if @user.save
        clear_uploaded_files(@user, :avatar)

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user.avatar }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user.avatar }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
```

## Multi upload with has_many

```erb
<%= form_for @product do |f| %>
  <%= f.input :name %>
  <%= f.input :price %>
  <%= instant_upload_for @product, :images, multi: :field_in_image_model, version: :thumb, limit: 10 %>
  <%= f.button :submit %>
<% end %>
```

``` ruby
class ProductsController < ApplicationController
  # GET /products/new
  def new
    @product = Product.new
    load_uploaded_files(@product, :images, multi: :field_in_image_model)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    return if handle_upload(@product, :images, multi: :field_in_image_model)

    respond_to do |format|
      if @product.save
        # clear images saved in session
        clear_uploaded_files(@product, :images)

        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render json: @product.images }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
end
```
