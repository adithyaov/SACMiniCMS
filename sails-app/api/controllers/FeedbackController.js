/**
 * FeedbackController
 *
 * @description :: Server-side logic for managing Feedbacks
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	'customCreate': (req, res) => {
		var name;
		var email;
		var message;
		name = req.body.name
		email = req.body.email
		message = req.body.message

		emptyStr = (str) => (str.trim() == '')
		isEmail = (str) => (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(str))

		// Check attributes
		if (emptyStr(name) || emptyStr(email) || emptyStr(message)) {
			return res.json({status: false, message: "All fields with * are required"})
		}

		if (!isEmail(email)) {
			return res.json({status: false, message: "Please enter a valid email"})
		}

		var saveObj = {
			name: name,
			email: email,
			message: message
		}

		Feedback.create(saveObj).exec(function (err, created){
			if (err) {
				return res.json({error: err})
			}
			return res.json({status: true, message: "May the force be with you :-)"})
		});
	}
};