var connect = require("connect");
var accept  = require("http-accept");
var httpProxy = require("http-proxy");

var page_server = require("../node_modules/punch/lib/page_server.js");

module.exports = {

  config: {},

	startServer: function(config){
	var self = this;

	// extend the default configuration
	self.config = config;

		var app = connect.call();

		var proxy = new httpProxy.RoutingProxy({
			changeOrigin: true
		});

		// log requests
		app.use( connect.logger("short") );

		// set access types in request object
		app.use(accept);

		// parse cookies
		app.use( connect.cookieParser() );

		// compress responses to GZip/Deflate
		app.use( connect.compress() );

		app.use( function(req, res, next){
			if(req.url.indexOf(config.proxy.path) === 0){
				req.url = req.url.substring(config.proxy.path);
				proxy.proxyRequest(req, res, {
					host: config.proxy.host,
					port: config.proxy.port
				});
			}
			else{
				return next();
			}
		});

		// there will be 3 main middlewares
		// page server - servers rendered or cached pages
		// api server - gives access to puch template & content API (/api)
		// editor - loads the pages with editing capablities (/editor)
		app.use( page_server.setup(self.config) );

		app.listen(self.config.server.port);

		console.log("Started Punch server on port %s", self.config.server.port);
	}
};
