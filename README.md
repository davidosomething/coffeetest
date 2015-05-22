# coffeescript + browserify skeleton

> Skeleton app that uses __CoffeeScript__, __browserify__, __Backbone.js__,
> & __react.js__

| Name           | Link |
| -------------- | -------------- |
| Home:          | [https://github.com/davidosomething/coffeetest](https://github.com/davidosomething/coffeetest)
| Upstream:      | [git@github.com:davidosomething/coffeetest.git](git@github.com:coffeetest/coffeetest.git)
| Issues:        | [https://github.com/davidosomething/coffeetest/issues](https://github.com/davidosomething/coffeetest/issues)
| NPM            | [![David dependency status][davidBadge]][davidLink] [![Development Dependency Status][davidDevBadge]][davidDevLink] [![Peer Dependency Status][davidPeerBadge]][davidPeerLink]

## About

- Frontend app development
  - __CoffeeScript__ is the scripting language of choice
  - Module bundling
    - __CommonJS__ is the module definition of choice
    - __Browserify__ is the module bundler, transforming through
      __coffee-reactify__
      - All modules are aliased relative to `app/` -- so instead of
        `../../modulefolder/mymodule` you can just do `modulefolder/mymodule`.
      - __coffee-reactify__ is the browserify transform that handles
        coffeescript AND cjsx so full React support is available.
  - Libraries and frameworks
    - __lodash__ is provided in place of __Underscore__ via a browserify alias
    - __jQuery__ and __Modernizr__ from the window scope are shimmed as a CommonJS
      module
    - __Backbone__ is provided and uses the shimmed libraries as modules
    _ __react__ is provided via npm module
  - Templating is done in __mustache__ using __Hogan.js__ as the compiler
  - Minification of compiled js files is done as a standalone step using
    __UglifyJS__. The minified files are given a `.min.js` extension and
    sourcemapped to their unminified versions.
- Tooling
  - __Grunt__ is the build tool
    - Provides `browserify`
    - Provides `clean`
    - Provides `hogan` to compile mustache templates into a CommonJS module
      that exposes them as `templates.mytemplate({ data })`
    - Provides `karma:run`
    - Provides `bg` to watch all coffee and run watchify and karma on update
- Testing
  - __Karma__ is the test runner with code coverage support through
    __browserify-istanbul__. Run it using `grunt karma:run`.
  - __Mocha__ is the test framework
  - __Chai__ is the assertion library, with __sinon__ for spies.
    - __chai-as-promised__ available in karma
    - __chai-backbone__ NOT available in karma -- add the line
      `chai.use require('chai-backbone')` in the test spec if you want it
    - __chai-jquery__ available in karma
  - Reporting
    - __browserify-istanbul__ transforms the code using __istanbul__, which
      delegates to __ibrik__ for CoffeeScript.
    - Note: HTML report generation is currently broken in istanbul, but you can
      manually generate one from the LCOV file using the cli tool `genhtml`
      which should come with `lcov` (install that via your OS package manager)
      Ideally you should be sending reports to an aggregation service like
      [coveralls](https://coveralls.io/) anyway.

## Usage

1. Install global deps

 ```bash
npm i -g grunt-cli karma-cli
```

1. Install project deps

 ```bash
npm i
```

1. Compile project

 ```bash
grunt                 # runs clean, hogan, browserify, uglify
```

1. Run tests

 ```bash
grunt karma:run       # single run of karma tests
```

1. Watch and re-test/compile on changes

 ```bash
grunt bg              # starts karma server and keeps watchify processes alive
```

## Configuration

- Edit config in `app/config/bundles.coffee`
- Edit `browserify-shims` in `package.json` to shim things (i.e., make a
  global into a CommonJS-requirable)

## Changelog

- 2015-05-21
  - introduce build folder
  - react.js support via CJSX and coffee-reactify, including demo of react
    component rendering
  - uglification with sourcemaps

- 2015-05-20
  - karma integration up and running, changed bundle paths, add watch config,
    update readme
  - add hogan

- 2015-05-12
  - up and running


[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)


Copyright (c) 2015 David O'Trakoun <me@davidosomething.com>


[davidBadge]:       https://david-dm.org/davidosomething/coffeetest.png?theme=shields.io
[davidLink]:        https://david-dm.org/davidosomething/coffeetest#info=dependencies
[davidDevBadge]:    https://david-dm.org/davidosomething/coffeetest/dev-status.png?theme=shields.io
[davidDevLink]:     https://david-dm.org/davidosomething/coffeetest#info=devDependencies
[davidPeerBadge]:   https://david-dm.org/davidosomething/coffeetest/peer-status.png?theme=shields.io
[davidPeerLink]:    https://david-dm.org/davidosomething/coffeetest#info=peerDependencies

