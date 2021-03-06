githubcopy
============

[![Build Status](https://secure.travis-ci.org/nachbarshund/githubcopy.png?branch=master)](http://travis-ci.org/nachbarshund/githubcopy)
[![Windows Tests](https://img.shields.io/appveyor/ci/nachbarshund/githubcopy.svg?label=Windows%20Test)]()
[![Dependency Status](https://david-dm.org/nachbarshund/githubcopy.png)](https://david-dm.org/nachbarshund/githubcopy)
[![NPM version](https://badge.fury.io/js/githubcopy.png)](http://badge.fury.io/js/githubcopy)

Module description

[![NPM](https://nodei.co/npm/githubcopy.png?downloads=true&stars=true)](https://nodei.co/npm/githubcopy/)

## Install

```
  npm i -g githubcopy
```

## Run on terminal

```shell
  githubcopy
```

## Todos

 * implement test cases to check for correct template generation.

## Advanced tipp
You can add a global configuration file to set the access token there, e.g. `~/username/.globalconfig.json`:

```
{
	"github": {
		"accessToken": "abcdefghijk12345"
	}
}
```

## Testing

The tests are based on the [mocha.js](https://mochajs.org/) framework with [should.js](https://shouldjs.github.io/) as assertaion lib.
To start the test just call

```
	npm test
```

or

```
	grunt test
```

If you want to be more precice use the mocha cli

```
	mocha -R nyan -t 1337 test/main.js
```


## Release History
|Version|Date|Description|
|:--:|:--:|:--|
|1.1.0|2016-5-23|Add global configuration for access token|
|1.0.0|2016-5-23|Initial commit|

[![NPM](https://nodei.co/npm-dl/githubcopy.png?months=6)](https://nodei.co/npm/githubcopy/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## The MIT License (MIT)

Copyright © 2016 C. Zotter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
