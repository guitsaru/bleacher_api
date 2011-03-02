BleacherApi
===========

A Ruby interface to the Bleacher Report API.

Requirements
------------

<pre>
gem install bleacher_api
</pre>

POST /api/article/article.json
------------------------------

### Parameters

* id - Article ID (required)
* article - When given any value, action includes article body in JSON output
* article[entry_id] - Changes article body to a quick hit or live blog entry
* comments[page] - When given a page number, action includes comments in JSON output
* related_content - When given any value, action includes related content in JSON output

### Returns

An object with any of the following keys: article, comments, related_content.

The article value is an object with the keys body and object.

### Ruby Example

<pre>
BleacherApi::Article.article(595888, :article => true, :comments => { :page => 1 }, :related_content => true)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/article/article.json?id=595888&article=1&comments[page]=1&related_content=1
</pre>

POST /api/authenticate/login.json
---------------------------------

### Parameters

* user[email]
* user[password]

### Returns

Output similar to the <a href="#user_api">User API</a>.

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
* state
* country
* dma - Designated Market Area code
* ip - IP Address (defaults to IP of requesting machine, only used if city, state, country, and dma are empty)
* limit - Limit number of results (defaults to 5)

All parameters are optional.

### Returns

A hash of team information, similar to the team information in the <a href="#user_api">User API</a>:

<pre>
{
  "Dallas Mavericks": {
    "uniqueName": "dallas-mavericks",
    "logo": "dallas_mavericks.png",
    "displayName": "Dallas Mavericks",
    "shortName": "Mavericks"
  },
  "Dallas Cowboys": {
    "uniqueName": "dallas-cowboys",
    "logo": "dallas_cowboys.png",
    "displayName": "Dallas Cowboys",
    "shortName": "Cowboys"
  }
}
</pre>

### Ruby Examples

<pre>
BleacherApi::Geolocation.teams(
  :city => 'Dallas',
  :dma => 623,
  :state => 'Texas',
  :country => 'US',
  :limit => 10
)
</pre>

<pre>
BleacherApi::Geolocation.teams(
  :ip => '64.55.149.162'
)
</pre>

<pre>
BleacherApi::Geolocation.teams(
  :lat => '37.787082',
  :long => '-122.400929'
)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/geolocation/teams.json?city=Dallas&dma=623&state=Texas&country=USA&limit=10
</pre>

<pre>
http://bleacherreport.com/api/geolocation/teams.json?ip=64.55.149.162
</pre>

<pre>
http://bleacherreport.com/api/geolocation/teams.json?lat=37.787082&long=-122.400929
</pre>

POST /api/related/channel.json
------------------------------

### Parameters

* article\_id - Article ID, must be present if no tag\_id specified
* tag\_id - Tag ID, must be present if no article\_id specified

### Returns

An array of article objects with the following keys: permalink, channel\_primary\_image, and title.

### Ruby Example

<pre>
BleacherApi::Related.channel(:article_id => 595888)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/related/channel.json?article_id=595888
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

<a name="user_api"></a>

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
* api

The <code>api</code> value contains extra information especially for the API. Example output:

<pre>
{
  "teams": {
    "Dallas Mavericks": {
      "uniqueName": "dallas-mavericks",
      "logo": "dallas_mavericks.png",
      "displayName": "Dallas Mavericks",
      "shortName": "Mavericks"
    },
    "Dallas Cowboys": {
      "uniqueName": "dallas-cowboys",
      "logo": "dallas_cowboys.png",
      "displayName": "Dallas Cowboys",
      "shortName": "Cowboys"
    }
  }
}
</pre>

### Ruby Example

<pre>
BleacherApi::User.user('token')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/user/user.json?token=TOKEN_OBTAINED_FROM_LOGIN_GOES_HERE
</pre>

Running Specs
-------------

Here is an example of the options available when running the specs:

<pre>
LOGIN=user@user.com PASSWORD=password URL=http://localhost ONLY=geolocation spec spec
</pre>

<code>LOGIN</code> and <code>PASSWORD</code> are required.

<code>URL</code> defaults to "http://bleacherreport.com".

<code>ONLY</code> is optional, and allows you to only run a specific group of specs.