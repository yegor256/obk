<img src="/logo.svg" width="64px" height="64px"/>

[![EO principles respected here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/obk)](http://www.rultor.com/p/yegor256/obk)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Build Status](https://travis-ci.org/yegor256/obk.svg)](https://travis-ci.org/yegor256/obk)
[![Build status](https://ci.appveyor.com/api/projects/status/pexc3cg49m75c0r6?svg=true)](https://ci.appveyor.com/project/yegor256/obk)
[![Gem Version](https://badge.fury.io/rb/obk.svg)](http://badge.fury.io/rb/obk)
[![Maintainability](https://api.codeclimate.com/v1/badges/51b007d0eb24ceeeca94/maintainability)](https://codeclimate.com/github/yegor256/obk/maintainability)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/yegor256/obk/master/frames)

[![Hits-of-Code](https://hitsofcode.com/github/yegor256/obk)](https://hitsofcode.com/view/github/yegor256/obk)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/obk/blob/master/LICENSE.txt)

First, install it:

```bash
$ gem install obk
```

Then, use it like this:

```ruby
require 'obk'
obj = Obk.new(obj, pause: 500)
obj.foo
# Forced 500ms delay here
obj.foo
```

There will be a forced delay of 500 milliseconds between `.foo` calls.

Keep in mind that `Obk` is _not_ thread-safe.

## How to contribute

Read [these guidelines](https://www.yegor256.com/2014/04/15/github-guidelines.html).
Make sure you build is green before you contribute
your pull request. You will need to have [Ruby](https://www.ruby-lang.org/en/) 2.3+ and
[Bundler](https://bundler.io/) installed. Then:

```
$ bundle update
$ bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.
