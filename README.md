

Ruby version is 3.0.4
Rails version is 7.0.3

This is an API project where we tested the functionality of the JWT library. The application has only 2 tables: 'users' and 'books' having a one-to-many relationship.
How does it work?
The user writes the login data in the front-end and sends them to our application. The application checks if the user and password are ok. If it is OK, a token is created. The token has 3 parts: The first part contains the algorithm used for coding in our HS256 case. The second contains some data including the user id. And the third part contains the secret key. This token is sent to the front-end and there it is stored in cookies. And from this moment , whenever the front-end wants to access a resource from our application, it sends the request to our application and adds the token in the header. Thus, the backend knows who made the request and offer access to that resource or not.
