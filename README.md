# README

### Follow the below setup instructions to successfully run the application.

* Ruby version
	* The application is developed using Ruby 2.4 and Rails 5.1

* Application Gem Setup
	* Run below command to install all the gems
	```
	bundle install
	```

* Database Setup
	* Run below commands to setup the database
	```
	rake db:create
	rake db:migrate
	rake db:seed
	```

* Services (job queues, cache servers, search engines, etc.)
	* The application uses Crono gem to implement backround jobs. The account service key is fetched as soon as the user record is created as a callback. If the service is down for unkown reason we have a null value in the database and the Crono configuration as defined in "cronotab.rb" file kicksoff every 10.seconds to check if there are any users with no account_service_key in the database and creates a job in the background to fetch it from the service.

	* Run the below command to run the jobs created by Crono in the background.
	```
	bundle exec crono start RAILS_ENV=development
	```

	* Crono also has a WebUI and can be viewed at below address
	http://localhost:3000/crono

* How to run the test suite
	* Use below command to run rspec suite
	```
	rspec spec
	```

### Below are sample request's for the user service api's.


* Sample GET URL's to fetch list of users
	* With query parameter
	```
	http://localhost:3000/api/v1/users?query=age%2032
	http://localhost:3000/api/v1/users?query=educated
	```
	* Without query parameter
	```
	http://localhost:3000/api/v1/users
	```


* Sample POST request for creating a user
	* Reuest URL
	http://localhost:3000/api/v1/users
	* Request Headers
	```
	Content-Type: application/json
	```

	* Request Body
	```
	{
		"user":	{
			"email": "user30@example.com",
			"phone_number": "5551235530",
			"full_name": "John Snow",
			"password": "mypassword38",
			"metadata": "male, age 30, unemployed, college"
		}
	}
	```