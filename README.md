Install global dependencies
```npm install -g karma bower```

then run
```npm install```

the karma coffee preprocessor adds a suffix, so you need to remove it based on [this commit](https://github.com/karma-runner/karma-coffee-preprocessor/commit/14b1835aacc0b930f4cf5ef0effd4500acb1cc15)

TODO:
- add editor config
- ~~proxy for api calls~~
- build process with hashing
- publishing
