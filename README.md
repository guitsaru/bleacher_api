BleacherApi
===========

A Ruby interface to the Bleacher Report API.

Requirements
------------

<pre>
gem install bleacher_api
</pre>

Table of Contents
-----------------

* [GET /api/article/article.json](#article_article)
* [POST /api/authenticate/login.json](#authenticate_login)
* [GET /api/authenticate/logout.json](#authenticate_logout)
* [GET /api/authenticate/signup](#authenticate_signup)
* [GET /api/front/lead_articles.json](#front_lead_articles)
* [GET /api/geolocation/teams.json](#geolocation_teams)
* [GET /api/related/channel.json](#related_channel)
* [GET /api/related/channel_next.json](#related_channel_next)
* [GET /api/stream/first.json](#stream_first)
* [GET /api/user/user.json](#user_user)

<a name="article_article"></a>

GET /api/article/article.json
-----------------------------

### Parameters

* id - Article ID (required)
* article - When given any value, action includes article body in JSON output
* article[entry_id] - Changes article body to a quick hit or live blog entry
* article[only] - When given comma-separated parameters, returns only values for the parameters in JSON output
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

<a name="authenticate_login"></a>

GET /api/authenticate/login
---------------------------

### Parameters

* redirect_url
* type (optional) - Optional values for this include: "fantasy"

### HTTP Example

<pre>
http://bleacherreport.com/api/authenticate/login?redirect_url=http://bleacherreport.com&type=fantasy
</pre>

### Redirect

A `redirect_url` parameter is mandatory. B/R will redirect the request back to that URL, passing basic information
from the <a href="#user_user">User API</a> as GET parameters.

POST /api/authenticate/login.json
---------------------------------

### Parameters

* user[email]
* user[password]

### Returns

Output similar to the <a href="#user_user">User API</a>.

### Ruby Example

<pre>
BleacherApi::Authenticate.login('email', 'password')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/authenticate/login.json?user[email]=your@email.com&user[password]=your_password
</pre>

Please note that any request with a password should be sent as a POST, despite this example using GET.

<a name="authenticate_logout"></a>

GET /api/authenticate/logout.json
---------------------------------

### Parameters

* redirect_url (optional)

### Returns

Returns `true` if succeeded, `false` if not.

### Ruby Example

<pre>
BleacherApi::Authenticate.logout
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/authenticate/logout.json
</pre>

### Redirect

When a `redirect_url` parameter is specified, B/R will redirect the request back to that URL, passing a `fail=1` parameter
if the logout failed.

<a name="authenticate_signup"></a>

GET /api/authenticate/signup
----------------------------

### Parameters

* redirect_url
* type (optional) - Optional values for this include: "fantasy"

### Returns

An HTML page with a sign up form.

### HTTP Example

<pre>
http://bleacherreport.com/api/authenticate/signup?redirect_url=http://bleacherreport.com&type=fantasy
</pre>

### Redirect

A `redirect_url` parameter is mandatory. B/R will redirect the request back to that URL, passing basic information
from the <a href="#user_user">User API</a> as GET parameters.

<a name="front_lead_articles"></a>

GET /api/front/lead_articles.json
---------------------------------

### Parameters

* limit - Optional

### Returns

An array of article objects with the following keys: permalink, primary\_image\_650x440, and title.

The array of articles represents the articles currently on the lead module of the front page.

### Ruby Example

<pre>
BleacherApi::Front.lead_articles(:limit => 2)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/front/lead_articles.json?limit=2
</pre>

<a name="geolocation_teams"></a>

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

A hash of team information, similar to the team information in the <a href="#user_user">User API</a>:

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

<a name="related_channel"></a>

GET /api/related/channel.json
-----------------------------

### Parameters

* article\_id - Article ID, must be present if no tag\_id specified
* tag\_id - Tag ID, must be present if no article\_id specified
* page - Optional

### Returns

An array of article objects with the following keys: permalink, channel\_primary\_image, and title.

### Ruby Example

<pre>
BleacherApi::Related.channel(:article_id => 595888, :page => 2)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/related/channel.json?article_id=595888&page=2
</pre>

<a name="related_channel_next"></a>

GET /api/related/channel_next.json
----------------------------------

### Parameters

* article\_id - Article ID, must be present if no tag\_id specified
* tag\_id - Tag ID, must be present if no article\_id specified
* limit - Limit number of results, defaults to 1

### Returns

An array of article objects with the following keys: permalink, channel\_primary\_image\_150x100, and dynamic_hook.

These article objects represent the next items in the channel (after the passed `article_id`).

### Ruby Example

<pre>
BleacherApi::Related.channel_next(:article_id => 595888, :tag_id => 19, :limit => 2)
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/related/channel_next.json?article_id=696286&tag_id=19&limit=2
</pre>

<a name="stream_first"></a>

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
* label

This object represents the first item in that team's stream.

### Ruby Example

<pre>
BleacherApi::Stream.first('san-francisco-49ers')
</pre>

### HTTP Example

<pre>
http://bleacherreport.com/api/stream/first.json?tags=san-francisco-49ers,dallas-cowboys
</pre>

<a name="user_user"></a>

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
