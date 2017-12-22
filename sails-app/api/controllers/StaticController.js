/**
 * StaticController
 *
 * @description :: Server-side logic for managing Statics
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {

	'customUpdate': (req, res) => {
		var key;
		var value;
		key = req.body.key
		value = req.body.value
		Static.update({key: key}, {value: value}).exec(function (err, updated){
			if (err) {
				return res.json({error: err})
			}
			return res.json({status: true, message: "Successfully updated to " + updated[0].value})
		});
	}
};





// 'customUpdate':  async (req, res) => {
// 		var homeImageBig;
// 		var homeDirName;
// 		var homeDirQuote;
// 		var councilSportsImg;
// 		var councilTechnicalImg;
// 		var councilCulturalImg;

// 		homeImageBig = req.body.homeImageBig
// 		homeDirName = req.body.homeDirName
// 		homeDirQuote = req.body.homeDirQuote
// 		councilSportsImg = req.body.councilSportsImg
// 		councilTechnicalImg = req.body.councilTechnicalImg
// 		councilCulturalImg = req.body.councilCulturalImg

// 		pairs = [
// 			{
// 				key: 'home.imageBig',
// 				value: homeImageBig
// 			},
// 			{
// 				key: 'home.directorQuote',
// 				value: homeDirQuote
// 			},
// 			{
// 				key: 'home.directorName',
// 				value: homeDirName
// 			},
// 			{
// 				key: 'council.sports.image',
// 				value: councilSportsImg
// 			},
// 			{
// 				key: 'council.technical.image',
// 				value: councilTechnicalImg
// 			},
// 			{
// 				key: 'council.cultural.image',
// 				value: councilCulturalImg
// 			},
// 		]

// 		pairs.forEach(function(item, index) {
// 			Static.update({key: item.key}, {value: item.value}).exec(function (err, updated){
// 				if (err) {
// 					return res.json({status: false, message: err})
// 				}
// 			})
// 		})

// 		return res.json({status: true, message: "Successfully updated"})
// 	}