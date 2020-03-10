# Recruitment Task
## Table of contents
* [Task Description](#task-description)
* [Usage](#usage)

## Task Description
### Task Summary
"The aim of this task is to build a simple API (backed by any kind of database). The application should be able to store geolocation data in the database, based on IP address or URL - you can use https://ipstack.com/ to get geolocation data. The API should be able to add, delete or provide geolocation data on the base of ip address or URL."
### Application specification
* It should be a RESTful API
* You can use https://ipstack.com/ for the geolocation of IP addresses and URLs
* The application can be built in any framework of your choice
* It is preferable that the API operates using JSON (for both input and output)
* The solution should also include base specs/tests coverage
### Notes
"We will run the application on our local machines for testing purposes. This implies that the solution should provide a quick and easy way to get the system up and running, including test data (hint: you can add Docker support so we can run it easily) We will test the behavior of the system under various "unfortunate" conditions (hint: How will the app behave when we take down the DB? How about the IPStack API?)"

## Usage
### Running the app (Docker)
* Download app
* Create .env file in a main directory with your access key to ipstack API. Should look like this: `IP_STACK=youripstackapiaccesskey`
* Inside a main directory run: `docker-compose up` This may take a while.
* When app is running in a separate terminal window run: `docker-compose run app rails db:migrate`

App should now be running on port 3000 on your Docker daemon. Go to http://localhost:3000 on a web browser to see the Rails Welcome.

### Making requests
### Show all saved ip/hostname/url geolocation data records
Send **GET** request to URL: http://localhost:3000/v1/ip_records

Postman example:
<p align="center">
    <img alt="show all" title="show" src="https://i.imgur.com/10Ml25L.png">
</p>

### Check ip/hostname/url geolocation data
You can look up ip, hostname or URL. URL needs to be HTML safe string.
If a record with such input exists you will receive its geolocation data. Otherwise, you will get ip/hostaname/url geolocation data from ipstack api (https://ipstack.com).

Send **GET** request to URL: http://localhost:3000/v1/ip-you-want-to-look-up

Examples:
* IP lookup: http://localhost:3000/v1/134.201.250.155
* Hostname lookup: http://localhost:3000/v1/www.google.com
* URL (HTML safe string - unsafe characters replaced with corresponding escape sequence) lookup: http://localhost:3000/v1/https%3A%2F%2Fwww.stillhavethem.com

Postman example:
<p align="center">
    <img alt="get request" title="get" src="https://i.imgur.com/JCh8y6B.png">
</p>

### Create ip/hostname/url geolocation data record
You can create geolocation data record based on ip, hostname or URL. URL needs to be HTML safe string.

Send **POST** request to URL: http://localhost:3000/v1/ip-you-want-to-add

No body is required. Record will be created based on data from ipstack api (https://ipstack.com).

Postman example:
<p align="center">
    <img alt="create request" title="create" src="https://i.imgur.com/nhT5cru.png">
</p>

### Delete ip/hostname/url geolocation data record
Destroy geolocation data.

Send **DELETE** request to URL: http://localhost:3000/v1/input-of-a-record-you-want-to-delete

Postman example:
<p align="center">
    <img alt="delete" title="delete" src="https://i.imgur.com/h8pgAwT.png">
</p>
