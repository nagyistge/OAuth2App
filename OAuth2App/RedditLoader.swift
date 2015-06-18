//
//  RedditLoader.swift
//  OAuth2App
//
//  Created by Pascal Pfiffner on 3/27/15.
//  CC0, Public Domain
//

import Cocoa
import OAuth2


let RedditSettings = [
	"client_id": "IByhV1ZcpTI6zQ",                              // yes, this client-id will work!
	"client_secret": "",
	"authorize_uri": "https://www.reddit.com/api/v1/authorize",
	"token_uri": "https://www.reddit.com/api/v1/access_token",
	"scope": "identity",                                        // note that reddit uses comma-separated, not space-separated scopes!
	"redirect_uris": ["ppoauthapp://oauth/callback"],           // app has registered this scheme
	"verbose": true,
]


/**
	Simple class handling authorization and data requests with Reddit.
 */
class RedditLoader: Loader
{
	static let sharedInstance = RedditLoader()
	
	
	// MARK: - Instance
	
	let baseURL = NSURL(string: "https://oauth.reddit.com")!
	
	lazy var oauth2 = OAuth2CodeGrant(settings: RedditSettings)
	
	/** Start the OAuth dance. */
	func authorize(callback: (wasFailure: Bool, error: NSError?) -> Void) {
		oauth2.afterAuthorizeOrFailure = callback
		oauth2.authorize(params: ["duration": "permanent"])
	}
	
	
	// MARK: - Convenience
	
	func requestUserdata(callback: ((dict: NSDictionary?, error: NSError?) -> Void)) {
		request("api/v1/me", callback: callback)
	}
}

