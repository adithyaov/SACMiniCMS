/**
 * AuthController
 *
 * @description :: Server-side logic for managing Auths
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

var GoogleAuth = require('google-auth-library');
var CLIENT_ID = '680003514575-bi52bp4vklcldhd50etorj6k0og6jvni.apps.googleusercontent.com'

module.exports = {

    'loginStatus': (req, res) => {
        res.json({sessionState: req.session.state, sessionEmail: req.session.admin})
    },
	
	'googleApi': async (req, res) => {
        try {
			var token;
			var adminList;

			adminList = ['111501017@smail.iitpkd.ac.in']

            token = req.params.token

            var auth = new GoogleAuth;
            var client = new auth.OAuth2(CLIENT_ID, '', '');
            client.verifyIdToken(
                token,
                CLIENT_ID,
                async function(e, login) {
                    if (e) {
                        return res.json({error: e, prob: "Client"})
                    }
                    var payload = login.getPayload()
                    var userid = payload['sub']
                    var domain = payload['hd']
                    var aud = payload['aud']
                    var email = payload.email

                    var audCheck = (aud == CLIENT_ID)
                    var validAdminCheck = (adminList.indexOf(email) >= 0)

                    if (validAdminCheck && audCheck) {
	                    // Start session
                        req.session.state = true
	                    req.session.admin = email
	                    return res.json({status: true, message: "Hi Admin!"})
                    } else {
                        req.session.state = false
                    	return res.json({error: "Not Authorised"})
                    }
                }
            );
        } catch (e) {
            return res.json({error: e})
        }
	}
};

