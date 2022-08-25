# Scim

Using `https://firezone-saml.loca.lt` as your SCIM endpoint

## Start server

```
mix run --no-halt
```

## Start tunnel

```
npm i -g localtunnel
```

```
lt -p 4001 -s firezone-saml
```

Go to `https://firezone-saml.loca.lt` and click the button the enable the tunnel.

## Users Index

`GET /Users` - mocked with GitHub example, see [code](/lib/scim.ex#L16)

## User Show

`GET /Users/:id` - mocked with GitHub example, see [code](/lib/scim.ex#L62)


## Provision / Deprovision testing data

I created a `Jane Smith` on my Okta account.

## Provision request

Okta performs the following sequence

1. `GET /Users?startIndex=1&count=100&filter=userName eq "..."` first
1. `GET /Users/:id`
1. finally `PUT /Users/:id` with IdP data merged with whatever returned from `GET /Users/:id`

`PUT` - body params is IdP data merged with response of `GET /Users/:id returns`

```elixir
%Plug.Conn{
  adapter: {Plug.Cowboy.Conn, :...},
  assigns: %{},
  body_params: %{
    "active" => true,
    "displayName" => "Jane Smith",
    "emails" => [
      %{"primary" => true, "type" => "work", "value" => "jane@test.com"}
    ],
    "externalId" => "00u6a15d23T9AeHhF5d7",
    "groups" => [],
    "id" => "5fc0c238-1112-11e8-8e45-920c87bdbd75",
    "locale" => "en-US",
    "meta" => %{
      "created" => "2018-02-13T15:05:24.000-08:00",
      "lastModified" => "2018-02-13T15:05:55.000-08:00",
      "location" => "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "resourceType" => "User"
    },
    "name" => %{
      "familyName" => "Smith",
      "formatted" => "Mona Octocat",
      "givenName" => "Jane"
    },
    "schemas" => ["urn:ietf:params:scim:schemas:core:2.0:User"],
    "userName" => "jane@test.com"
  },
  cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  halted: false,
  host: "firezone-saml.loca.lt",
  method: "PUT",
  owner: #PID<0.3254.0>,
  params: %{
    "active" => true,
    "displayName" => "Jane Smith",
    "emails" => [
      %{"primary" => true, "type" => "work", "value" => "jane@test.com"}
    ],
    "externalId" => "00u6a15d23T9AeHhF5d7",
    "groups" => [],
    "id" => "5fc0c238-1112-11e8-8e45-920c87bdbd75",
    "locale" => "en-US",
    "meta" => %{
      "created" => "2018-02-13T15:05:24.000-08:00",
      "lastModified" => "2018-02-13T15:05:55.000-08:00",
      "location" => "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "resourceType" => "User"
    },
    "name" => %{
      "familyName" => "Smith",
      "formatted" => "Mona Octocat",
      "givenName" => "Jane"
    },
    "schemas" => ["urn:ietf:params:scim:schemas:core:2.0:User"],
    "userName" => "jane@test.com"
  },
  path_info: ["Users", "5fc0c238-1112-11e8-8e45-920c87bdbd75"],
  path_params: %{},
  port: 80,
  private: %{
    plug_route: {"/*_path", #Function<7.69133781/2 in Scim.do_match/4>}
  },
  query_params: %{},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  req_headers: [
    {"accept", "application/scim+json"},
    {"accept-charset", "utf-8"},
    {"accept-encoding", "gzip,deflate"},
    {"authorization", "Bearer abcdefg"},
    {"connection", "close"},
    {"content-length", "607"},
    {"content-type", "application/scim+json; charset=utf-8"},
    {"host", "firezone-saml.loca.lt"},
    {"user-agent", "Okta SCIM Client 1.0.0"},
    {"x-forwarded-for", "54.189.184.116"},
    {"x-forwarded-host", "firezone-saml.loca.lt"},
    {"x-forwarded-port", "443"},
    {"x-forwarded-proto", "https"},
    {"x-forwarded-ssl", "on"},
    {"x-real-ip", "54.189.184.116"}
  ],
  request_path: "/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
  scheme: :http,
  script_name: [],
  secret_key_base: nil,
  state: :unset,
  status: nil
}
```

## Deprovision request

Okta performs the following:

1. `GET /Users/:id` for the user
1. `PUT /Users/:id` with `active: false`
1. Removes the user from the application on, so on re-activation,
the admin has to add the user to the app again

```elixir
%Plug.Conn{
  adapter: {Plug.Cowboy.Conn, :...},
  assigns: %{},
  body_params: %{
    "active" => false,
    "displayName" => "Mona Octocat",
    "emails" => [%{"primary" => true, "value" => "octocat@github.com"}],
    "externalId" => "00u1dhhb1fkIGP7RL1d8",
    "id" => "5fc0c238-1112-11e8-8e45-920c87bdbd75",
    "meta" => %{
      "created" => "2018-02-13T15:05:24.000-08:00",
      "lastModified" => "2018-02-13T15:05:55.000-08:00",
      "location" => "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "resourceType" => "User"
    },
    "name" => %{
      "familyName" => "Octocat",
      "formatted" => "Mona Octocat",
      "givenName" => "Mona"
    },
    "schemas" => ["urn:ietf:params:scim:schemas:core:2.0:User"],
    "userName" => "octocat@github.com"
  },
  cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  halted: false,
  host: "firezone-saml.loca.lt",
  method: "PUT",
  owner: #PID<0.5260.0>,
  params: %{
    "active" => false,
    "displayName" => "Mona Octocat",
    "emails" => [%{"primary" => true, "value" => "octocat@github.com"}],
    "externalId" => "00u1dhhb1fkIGP7RL1d8",
    "id" => "5fc0c238-1112-11e8-8e45-920c87bdbd75",
    "meta" => %{
      "created" => "2018-02-13T15:05:24.000-08:00",
      "lastModified" => "2018-02-13T15:05:55.000-08:00",
      "location" => "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "resourceType" => "User"
    },
    "name" => %{
      "familyName" => "Octocat",
      "formatted" => "Mona Octocat",
      "givenName" => "Mona"
    },
    "schemas" => ["urn:ietf:params:scim:schemas:core:2.0:User"],
    "userName" => "octocat@github.com"
  },
  path_info: ["Users", "5fc0c238-1112-11e8-8e45-920c87bdbd75"],
  path_params: %{"id" => "5fc0c238-1112-11e8-8e45-920c87bdbd75"},
  port: 80,
  private: %{
    plug_route: {"/Users/:id", #Function<1.35044485/2 in Scim.do_match/4>}
  },
  query_params: %{},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  req_headers: [
    {"accept", "application/scim+json"},
    {"accept-charset", "utf-8"},
    {"accept-encoding", "gzip,deflate"},
    {"authorization", "Bearer abcdefg"},
    {"connection", "close"},
    {"content-length", "579"},
    {"content-type", "application/scim+json; charset=utf-8"},
    {"host", "firezone-saml.loca.lt"},
    {"user-agent", "Okta SCIM Client 1.0.0"},
    {"x-forwarded-for", "54.189.184.116"},
    {"x-forwarded-host", "firezone-saml.loca.lt"},
    {"x-forwarded-port", "443"},
    {"x-forwarded-proto", "https"},
    {"x-forwarded-ssl", "on"},
    {"x-real-ip", "54.189.184.116"}
  ],
  request_path: "/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
  scheme: :http,
  script_name: [],
  secret_key_base: nil,
  state: :unset,
  status: nil
}
```
