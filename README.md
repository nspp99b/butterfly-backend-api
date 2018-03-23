# BUTTERFLY

Rails 5 API backend for BUTTERFLY social messaging application, currently configured for development environment and PostgreSQL development database.  

To get started, clone the repo down, navigate into your clone directory, bundle install, then follow the below instructions to create and migrate the database.

Frontend repo is [here](https://github.com/nspp99b/butterfly-frontend)

[Demo](https://youtu.be/na1Eqad0zHw)

* Ruby version  
2.3.3

* System dependencies  
active_model_serializers  
bcrypt  
jwt  

* Database creation
To get started with a development database:  

rake db: create  
rake db: migrate

Then you're ready to start rails server:  
rails s -p 3001 (recommending 3001 to keep 3000 open for front end).

* Maintenance / Contribution
This is a student project and as such is no longer actively maintained.  

* License
[MIT](https://oss.ninja/mit?organization=Eric%20Kollegger) Copyright 2018 [Shahin Motia](https://github.com/nspp99b)
