# NPM modules
_ = require( "lodash" )
async = require( "async" )
GitHub = require( "octonode" )
ProgressBar = require( "progress" )

class GitHubCloner


	###
	## createRepository
	
	`github-copy-labels.createRepository( shared, next, error )`
	
	Create a new repository
	
	@param { Object } shared
	@param { Function } next Callback function 
	@param { Function } error Callback function
	
	@return { String } Return Desc 
	
	@api private
	###
	createRepository: ( shared, next, error ) =>
		if not @config.createNewRepo
			@targetrepo = @client.repo( @config.gitHubTargetName + "/" + @config.gitTargetRepo )
			next()
			return

		_repoData =
			name: @config.gitTargetRepo
			description: @config.newRepoDescrption
			private: @config.newRepoPrivate

		meclient = @client.me()
		
		meclient.repo _repoData, ( err, repository ) =>
			if err
				error( err )
				return

			console.log( "New repository created: #{ @config.gitTargetRepo } [SUCCESS]" )

			@targetrepo = @client.repo( @config.gitHubTargetName + "/" + @config.gitTargetRepo )

			setTimeout ->
				next()
				return
			, 1500
			return
		return

	
	###
	## createLabels
	
	`github-copy-labels.createLabels( shared, next, error )`
	
	Create all labels from source into target repository.
	
	@param { Object } shared
	@param { Function } next Callback function 
	@param { Function } error Callback function
	
	@api private
	###
	createLabels: ( shared, next, error ) =>
		@srcrepo.labels ( err, labels ) =>
			if err
				error( err )
				return

			@createProgressBar = new ProgressBar( "Start creating labels (Total: #{ labels.length } ) [:bar] :percent", { total: labels.length })


			aFns = []
			for label in labels
				aFns.push( @createLabel( label ) )
			
			async.series aFns, ( err, done ) ->
				if err
					error( err )
					return

				next()
				return
			return
		return


	###
	## createLabel
	
	`github-copy-labels.createLabel( label )`
	
	Create single label.
	
	@param { String } label
	
	@return { Function } Return  
	
	@api private
	###
	createLabel: ( label ) =>
		return ( next, error ) =>
			_newLabel = _.pick( label, [ "name", "color" ] )
			@targetrepo.label _newLabel, ( err, response ) =>
				@createProgressBar.tick()

				if err
					error( err )
					return

				next()
				return
			return


	###
	## deleteOldLabels
	
	`github-copy-labels.deleteOldLabels( shared, next, error )`
	
	Remove old labels from old repository
	
	@param { Object } shared
	@param { Function } next Callback function 
	@param { Function } error Callback function
	
	@return { String } Return Desc 
	
	@api private
	###
	deleteOldLabels:( shared, next, error ) =>
		

		@targetrepo.labels ( err, labels ) =>
			if err
				error( err )
				return
			
			@deleteProgressBar = new ProgressBar( "Start deleting old labels (Total: #{ labels.length } ) [:bar] :percent", { total: labels.length })

			aFns = []

			for label in labels
				aFns.push( @deleteSingleLabel( label ) )
			
			async.series aFns, ( err, done ) ->

				next()
				return
			return
		return


	###
	## deleteSingleLabel
	
	`github-copy-labels.deleteSingleLabel()`
	
	Delete a single label.
	
	@param { String } label
	
	@return { Function } Return Desc 
	
	@api private
	###
	deleteSingleLabel: ( label ) =>
		return ( next ) =>

			labelClient = @client.label( @config.gitHubTargetName + "/" + @config.gitTargetRepo, label.name  )

			labelClient.delete ( err, response ) =>
				@deleteProgressBar.tick()
				next( err )
				return
			return
		

	###
	## initSettings
	
	`github-copy-labels.initSettings( @config )`
	
	Init the settings for this application.
	
	@param { Object } @config 
	
	@api public
	###
	initSettings: ( @config ) =>
		# GitHub modules
		@client = GitHub.client( @config.accessToken )
		@srcrepo = @client.repo( @config.gitHubName + "/" + @config.gitSrcRepo )		
		return


	###
	## middleware
	
	`github-copy-labels.middleware()`
	
	Middlewarre funtcion.
	
	@api private
	###
	middleware: =>
		_error = false
		[ fns..., cb ] = arguments
		
		if not _.isFunction( fns[ 0 ] )
			data = fns.splice( 0 , 1 )[ 0 ]
		else
			data = {}
		
		_errorFn = ( error )->

			fns = []
			_error = true
			cb( error, data )
			return

		run = ->
			if not fns.length
				cb( null, data )
			else
				fn = fns.splice( 0 , 1 )[ 0 ]
				
				fn( data, ->
					run() if not _error
					return
				, _errorFn, fns )
		return run()


	###
	## run
	
	`github-copy-labels.run( cb )`
	
	Run the application.
	
	@param { Function } cb Callback function 
	
	@api public
	###
	run: ( cb ) =>
		console.log( "\n------ START githubcopy ------\n" )
		@middleware @createRepository, @deleteOldLabels, @createLabels, ( err, shared ) =>
			console.log( "\n------ END githubcopy ------\n" )
			cb( err, shared )
			return
		return


module.exports = new GitHubCloner()