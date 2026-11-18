# Welcome to My Users App
***

## Task
The goal of this project is to build a user management application using the MVC architecture. The application allows users
 to create, find, update, and delete users using an SQLite database. It also provides routes for signing in and signing out.
## Description
 solved this task using Ruby, Sinatra, and SQLite3. I created a User model to manage database operations and a controller to 
 handle HTTP requests. The application returns JSON responses for user routes and displays an HTML page at the root route.
## Installation
First, make sure Ruby is installed on your computer. This project uses Ruby, Sinatra, and SQLite3 to manage users and handle HTTP requests.

Install the required gems by running the following commands in your terminal:


gem install sinatra
gem install sqlite3
Clone or download the project and navigate to the project directory. Make sure that the files app.rb and my_user_model.rb are in the project directory and that the views directory contains the index.html file.

The SQLite database file named db.sql will be created automatically when the application connects to the database and creates the users table.

## Usage
To start the application, open your terminal, navigate to the project directory, and run the following command:


ruby app.rb
The Sinatra server will start on port 8080 and listen on 0.0.0.0, allowing access through a web browser.

Open the following URL to view the home page:


http://localhost:8080/
The application provides the following routes:

GET / displays the HTML home page.
GET /users returns all users in JSON format without passwords.
POST /users creates a new user.
POST /sign_in authenticates a user and creates a session.
PUT /users updates the password of the logged-in user.
DELETE /sign_out ends the current user session.
DELETE /users deletes the logged-in user and ends the session.
To create a user, send a POST request to /users with the firstname, lastname, age, password, and email parameters.

To sign in, send a POST request to /sign_in with the email and password. The session cookie can be saved and reused with curl to access protected routes.

This project demonstrates the use of the MVC architecture, database operations with SQLite3, HTTP routes with Sinatra, JSON responses, and session-based authentication.

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
