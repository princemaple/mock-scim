defmodule Scim do
  @moduledoc false
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello scim!!!")
  end

  get "/Users" do
    IO.inspect(conn, label: "GET /Users")

    conn
    |> put_resp_header("content-type", "application/json")
    # |> send_resp(200, """
    # {
    #   "schemas": [
    #     "urn:ietf:params:scim:api:messages:2.0:ListResponse"
    #   ],
    #   "totalResults": 1,
    #   "itemsPerPage": 1,
    #   "startIndex": 1,
    #   "Resources": [
    #     {
    #       "schemas": [
    #         "urn:ietf:params:scim:schemas:core:2.0:User"
    #       ],
    #       "id": "5fc0c238-1112-11e8-8e45-920c87bdbd75",
    #       "externalId": "00u1dhhb1fkIGP7RL1d8",
    #       "userName": "octocat@github.com",
    #       "displayName": "Mona Octocat",
    #       "name": {
    #         "givenName": "Mona",
    #         "familyName": "Octocat",
    #         "formatted": "Mona Octocat"
    #       },
    #       "emails": [
    #         {
    #           "value": "octocat@github.com",
    #           "primary": true
    #         }
    #       ],
    #       "active": true,
    #       "meta": {
    #         "resourceType": "User",
    #         "created": "2018-02-13T15:05:24.000-08:00",
    #         "lastModified": "2018-02-13T15:05:55.000-08:00",
    #         "location": "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75"
    #       }
    #     }
    #   ]
    # }
    # """)
    |> send_resp(200, """
    {
      "schemas": [
        "urn:ietf:params:scim:api:messages:2.0:ListResponse"
      ],
      "totalResults": 0,
      "itemsPerPage": 0,
      "startIndex": 0,
      "Resources": []
    }
    """)
  end

  get "/Users/:id" do
    IO.inspect(conn, label: "GET /Users/:id")

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, """
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "externalId": "00u1dhhb1fkIGP7RL1d8",
      "userName": "octocat@github.com",
      "displayName": "Mona Octocat",
      "name": {
        "givenName": "Mona",
        "familyName": "Octocat",
        "formatted": "Mona Octocat"
      },
      "emails": [
        {
          "value": "octocat@github.com",
          "primary": true
        }
      ],
      "active": true,
      "meta": {
        "resourceType": "User",
        "created": "2018-02-13T15:05:24.000-08:00",
        "lastModified": "2018-02-13T15:05:55.000-08:00",
        "location": "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75"
      }
    }
    """)
  end

  post "/Users" do
    IO.inspect(conn, label: "POST /Users")

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, """
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "externalId": "00u1dhhb1fkIGP7RL1d8",
      "userName": "octocat@github.com",
      "displayName": "Mona Octocat",
      "name": {
        "givenName": "Mona",
        "familyName": "Octocat",
        "formatted": "Mona Octocat"
      },
      "emails": [
        {
          "value": "octocat@github.com",
          "primary": true
        }
      ],
      "active": true,
      "meta": {
        "resourceType": "User",
        "created": "2018-02-13T15:05:24.000-08:00",
        "lastModified": "2018-02-13T15:05:55.000-08:00",
        "location": "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75"
      }
    }
    """)
  end

  put "/Users/:id" do
    IO.inspect(conn, label: "PUT /Users/:id")

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, """
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "5fc0c238-1112-11e8-8e45-920c87bdbd75",
      "externalId": "00u1dhhb1fkIGP7RL1d8",
      "userName": "octocat@github.com",
      "displayName": "Mona Octocat",
      "name": {
        "givenName": "Mona",
        "familyName": "Octocat",
        "formatted": "Mona Octocat"
      },
      "emails": [
        {
          "value": "octocat@github.com",
          "primary": true
        }
      ],
      "active": true,
      "meta": {
        "resourceType": "User",
        "created": "2018-02-13T15:05:24.000-08:00",
        "lastModified": "2018-02-13T15:05:55.000-08:00",
        "location": "https://api.github.com/scim/v2/organizations/octo-org/Users/5fc0c238-1112-11e8-8e45-920c87bdbd75"
      }
    }
    """)
  end

  match _ do
    IO.inspect(conn)
    send_resp(conn, 404, "oops")
  end
end
