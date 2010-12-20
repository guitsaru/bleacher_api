BleacherApi
===========

A Ruby interface to the Bleacher Report API.

Requirements
------------

<pre>
gem install bleacher_api
</pre>

POST /api/authenticate/login.json
---------------------------------

### Parameters

* user[email]
* user[password]

### Returns

A user object with the following keys:

* id
* email
* first\_name
* last\_name
* permalink
* token

### Ruby Example

<pre>
BleacherApi::Authenticate.login('email', 'password')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/authenticate/login.json?user[email]=your@email.com&user[password]=your_password
</pre>

Please note that any request with a password should be sent as a POST, despite this example using GET.

GET /api/geolocation/teams.json
-------------------------------

### Parameters

* city

### Returns

An array of team permalinks.

### Ruby Example

<pre>
BleacherApi::Geolocation.teams('Dallas')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/geolocation/teams.json?city=Dallas
</pre>

GET /api/stream/first.json
--------------------------

### Parameters

* tags - comma-delimited list of tag permalinks

### Returns

An object whose keys are the permalinks passed in via the <code>tags</code> parameter.

Each value of that object is another object with the following keys:

* title
* published_at
* image

This object represents the first item in that team's stream.

### Ruby Example

<pre>
BleacherApi::Stream.first('san-francisco-49ers')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/stream/first.json?tags=san-francisco-49ers,dallas-cowboys
</pre>

GET /api/user/user.json
-----------------------

### Parameters

* token - Token obtained from <code>/api/authenticate/login</code>

### Returns

A user object with the following keys:

* id
* email
* first\_name
* last\_name
* permalink
* token

### Ruby Example

<pre>
BleacherApi::User.user('token')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/user/user.json?token=TOKEN_OBTAINED_FROM_LOGIN_GOES_HERE
</pre>