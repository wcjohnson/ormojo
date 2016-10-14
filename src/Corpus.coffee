Model = require './Model'
Backend = require './Backend'

class Corpus
	constructor: (@config = {}) ->

		#### Export methods to make promises.
		@promiseResolve = @config.promiseResolve or ((x) -> Promise.resolve(x))
		@promiseReject = @config.promiseReject or ((x) -> Promise.reject(x))

		#### Get backends
		@backends = @config.backends or {}
		sz = 0
		for k,v of @backends
			sz++
			if not (v instanceof Backend) then throw new Error("Corpus: object at `#{k}` is not a backend")
			v._initialize(@, k)
		if sz is 0
			throw new Error("Corpus: must register at least one backend")

		@models = {}

	# Create a model within this Corpus with the given spec.
	createModel: (spec) ->
		if not spec?.name then throw new Error('createModel: name must be specified')
		if @models[spec.name] then throw new Error("createModel: duplicate model name `#{spec.name}`")

		m = new Model(@, spec)
		@models[m.name] = m
		m

	getModel: (name) -> @models[name]

	getBackend: (name) ->
		if @backends[name] then @backends[name] else throw new Error("No such backend #{name}")


module.exports = Corpus
