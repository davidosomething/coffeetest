# coffeescript + browserify skeleton

> Skeleton app that uses __CoffeeScript__, __browserify__, & __Backbone.js__<br>
> Uses __lodash__ instead of __Underscore__ via alias<br>
> Uses __jQuery__ from window scope shimmed as a CommonJS module

## Usage

1. Install global deps

 ```bash
npm i -g grunt-cli
npm i -g browserify
```

1. Install project deps

 ```bash
npm i
```

1. Compile project

 ```bash
grunt # runs browserify task with coffeeify transform
```

## Settings

- Edit config in `app/config/bundles.coffee`
- Edit `browserify-shims` in `package.json` to shim things (i.e., make a
  global into a CommonJS-requirable)

## Changelog

- 2015-05-12 - up and running

