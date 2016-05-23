# # Githubcopy

# ### extends [NPM:MPBasic](https://cdn.rawgit.com/mpneuried/mpbaisc/master/_docs/index.coffee.html)

# NPM modules
inquirer = require( "inquirer" )
ProgressBar = require( "progress" )
os = require( "os" )

# Internal modules
GitHubCloner = require( "./github-copy-labels" )


try
	GlobalConfig = require( os.homedir() + "/.globalconfig.json" )
catch e
	GlobalConfig =
		github: 
			accessToken: ""


#
# ### Exports: *Class*
#
# Main Module
# 

class Githubcopy


	###	
	## constructor 
	###
	constructor: () ->
		@start()
		return


	start: =>
		prompts = [
				name: "gitHubName"
				message: "Your GitHub username?"
				default: ""
			,
				name: "accessToken"
				message: "Your GitHub access token?"
				default: GlobalConfig.github.accessToken
			,
				name: "gitSrcRepo"
				message: "What's the name of the source repository?"
				default: "draft"
			,
				name: "createNewRepo"
				message: "Do you want to create a new repository?"
				default: false
				type: "confirm"
			,
				name: "newRepoPrivate"
				message: "Is the new repository private?"
				default: false
				type: "confirm"
				when: ( selection ) ->
					return selection.createNewRepo
			,
				name: "gitTargetRepo"
				message: "What is the name of the new repository?"
				default: ""
				when: ( selection ) ->
					return selection.createNewRepo
			,
				name: "newRepoDescrption"
				message: "What is the description of the new repository?"
				default: "My new repository"
				when: ( selection ) ->
					return selection.createNewRepo
			,
				name: "diffTargetUser"
				message: "Is there another GitHub user for target repository?"
				default: false
				type: "confirm"
				when: ( selection ) ->
					return not selection.createNewRepo
			,
				name: "gitHubTargetName"
				message: "What's the name of target GitHub user?"
				default: ""
				when: ( selection ) ->
					return selection.diffTargetUser
			,
				name: "gitTargetRepo"
				message: "What is the name of the target repository?"
				default: ""
				when: ( selection ) ->
					return not selection.createNewRepo

		]

		inquirer.prompt( prompts )
		.then ( settings ) ->
			# Check if there is another user name
			if not settings.gitHubTargetName?.length
				settings.gitHubTargetName = settings.gitHubName

			GitHubCloner.initSettings( settings )
			GitHubCloner.run ( err, resp ) ->
				console.log( "RESULTS:\n" )
				console.log( "Error:", err )
				console.log( "Success:", not err, "\n" )
				return
			return


		.catch ( error ) ->
			console.error( "CATCH", error )
			return
		return

#export this class
module.exports = new Githubcopy()