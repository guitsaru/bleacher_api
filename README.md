BleacherApi
===========

A Ruby interface to the Bleacher Report API.

Requirements
------------

<pre>
gem install bleacher_api
</pre>

Methods
-------

== POST /api/authenticate/login

=== Parameters

* email
* password

=== Returns

A user object with the following keys:

* id
* email
* first\_name
* last\_name
* permalink
* token

=== Example

<pre>
BleacherApi::Authenticate.login('email', 'password')
</pre>

== GET /api/geolocation/teams

=== Parameters

* city

=== Returns

An array of team permalinks.

=== Example

<pre>
BleacherApi::Geolocation.teams('Dallas')
</pre>

== GET /api/stream/first

=== Parameters

* tags - comma-delimited list of tag permalinks

=== Returns

An object whose keys are the permalinks passed in via the <code>tags</code> parameter.

Each value of that object is another object with the following keys:

* title
* published_at
* image

This object represents the first item in that team's stream.

=== Example

<pre>
BleacherApi::Stream.first('san-francisco-49ers')
</pre>

== GET /api/user/user

=== Parameters

* token - Token obtained from <code>/api/authenticate/login</code>

=== Returns

A user object with the following keys:

* id
* email
* first\_name
* last\_name
* permalink
* token

=== Example

<pre>
BleacherApi::Authenticate.user('token')
</pre>