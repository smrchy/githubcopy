should = require( "should" )

Module = require( "../." ) 

_moduleInst = null

describe "----- githubcopy TESTS -----", ->

	before: ( done ) ->
		_moduleInst = new Module()
		# TODO add initialisation Code
		done()
		return

	after: ( done ) ->
		done()
		return

	describe "Main Tests", ->

		# Implement tests cases here
		it "first test", ( done ) ->
			done()
			return
		return
	return