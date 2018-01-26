/**
 * MemberController
 *
 * @description :: Server-side logic for managing Members
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {

	'customDelete': (req, res) => {
		var key;
		var value;
		key = req.body.key
		value = req.body.value
		criteria = {}
		criteria[key] = parseInt(value)
		Member.destroy(criteria).exec(function (err){
			if (err) {
				return res.json({error: err})
			}
			return res.json({status: true, message: "Successfully deleted"})
		});
	}
};

