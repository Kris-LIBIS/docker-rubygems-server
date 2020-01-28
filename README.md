# docker-rubygems-server

Description
-----------

Docker image providing a [gem server](https://github.com/geminabox/geminabox) and mirror.

It is forked from [colstrom](https://github.com/colstrom/docker-rubygems-server), but I removed the Redis cache and replaced it with a simple
in-memory and Hash based cache for the authorizations. Authorization requests are cached for 10 minutes by default, but this can be overwritten
by setting the environment variable CAHCE_TTL.

I also upgraded the Github API to v4 and switched to GraphQL using the [Graphlient gem](https://github.com/ashkan18/graphlient).

Deploying your Gem Server
-------------------------

The server will run on local port 9292.

Run the server, best to provide local storage for server data:
```
docker run -d -v /local_data_path:/srv/gems -p 4040:9292 Kris-LIBIS/rubygems-server
```

Using your Gem Server
---------------------

Set your rubygems mirror by following:
* http://bundler.io/v1.10/bundle_config.html

```
bundle config mirror.https://rubygems.org http://<docker-host>:4040
```

* http://guides.rubygems.org/run-your-own-gem-server/#using-gems-from-your-server
```
gem sources --add http://<docker-host>:3000
```

Authenticating with GitHub
--------------------------

To restrict access to your Gem Server, you can set the environment variable: `GITHUB_ORGANIZATION` to the organization you want to restrict access to.

If set, the Gem Server will require a valid GitHub token with `read:org` permissions, provided as a 'password' via HTTP Basic Auth.

If the user associated with the token is a member of the `GITHUB_ORGANIZATION` you set, that user will have access.

Your authentication will be valid for 10 minutes, after which your token will be used to check the github authorization again. You can override the TTL for
these authorization requests by setting the environment variable `CACHE_TTL` to the number of seconds you want the server to remember your authorization. The 
default value is 600 (10 minutes).

License
-------
[MIT](https://tldrlegal.com/license/mit-license)

Contributors
------------
* [Chris Olstrom](https://colstrom.github.io/) | [e-mail](mailto:chris@olstrom.com) | [Twitter](https://twitter.com/ChrisOlstrom)
* [mookjp](https://github.com/mookjp)
* [Kris Dekeyser](https://github.com/Kris-LIBIS)