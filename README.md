## README

This sample application details how to connect and interact with Peloton API's.

Examples included are for:

### SOAP
 * EppBanking
   * AddBankAccount

### REST
Coming in 2015

###  Setup
* Install ruby version `1.9.3-p547`
  * `rbenv install 1.9.3-p547`
* Clone the repo
  * `git clone https://github.com/pelotontech/demo-app.git`
* Install gems with `bundler`
  * `bundle install`
* Run the app in development
  * `bundle exec rails server`
* Set the appropriate values in [`config/peloton.yml`](https://github.com/pelotontech/demo-app/blob/master/config/peloton.yml)
* Run the app in development
  * `bundle exec rails server`

### Configuration
Create `config/peloton.yml`:

```yml
# config/peloton.yml
common: &default_settings
  client_id: 'your client id'
  account_name: 'your account name'
  password: 'your password'
development:
  <<: *default_settings
test:
  <<: *default_settings
production:
  <<: *default_settings
```

### Usage

* Visit http://localhost:3000
* The form's elements are handled by [`peloton#api`](https://github.com/pelotontech/demo-app/blob/master/app/controllers/peloton_controller.rb). The [`Peloton::BankAccount`](https://github.com/pelotontech/demo-app/blob/master/app/services/peloton/bank_account.rb) class encapsulates the underlying transport to Peloton's APIs.

