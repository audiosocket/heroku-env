# Heroku Env

Quick-and-dirty patches to smooth out our Heroku workflow.

## .heroku-env

Create this (YAML) file in the root of your project. It should look
something like:

    default: next
    pattern: audiosocket-awesometown-%s

With this plugin installed, information in this file will be used to
make Heroku run more smoothly. Since we don't normally have git
remotes for Heroku on our local dev machines, it lets you specify a
default app name.

If you specify a pattern, it'll be used to munge the `--app` argument
if it's passed. Use `%s` to mark the part of the pattern you'd like to
replace:

    $ heroku foo --app master  # is actually...
    $ heroku foo --app audiosocket-awesometown-master

If you specify a default, it'll be added and expanded as well:

    $ heroku foo  # is actually...
    $ heroku foo --app audiosocket-awesometown-next

It'll also try to be smart about `--app` when it shouldn't be munged,
but no guarantees.

## Releasing

There's a `release` command, which is dangerously simple:

    $ heroku release  # is actually...
    $ git push -f git@heroku.com:audiosocket-awesometown-next.git HEAD:master

## Install/Upgrade

    $ heroku plugins:install git@github.com:audiosocket/heroku-env.git

## License (MIT)

Copyright 2011 Audiosocket (it@audiosocket.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
