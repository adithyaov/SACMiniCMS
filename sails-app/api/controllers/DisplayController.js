/**
 * DisplayController
 *
 * @description :: Server.side logic for managing Displays
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	
	'home': async (req, res) => {
		try {
			var directorName;
			var directorQuote;
			var imageBig;
			var content;

			directorName = await Static.findOne({key: 'home.directorName'})
			directorQuote = await Static.findOne({key: 'home.directorQuote'})
			imageBig = await Static.findOne({key: 'home.imageBig'})
			content = await Post.find({
				where: {page: 'home'},
				limit: 10,
				sort: 'position ASC'
			})

			returnObj = {
				directorName: directorName.value,
				directorQuote: directorQuote.value,
				imageBig: imageBig.value,
				content: content,
				directorNameId: directorName.id,
				directorQuoteId: directorQuote.id,
				imageBigId: imageBig.id,
			}

			console.log(returnObj)

			res.json(returnObj)
		} catch (e) {
			res.json({error: e})
		}
	},

	'members': async (req, res) => {
		try {
			var members;

			members = await Member.find({page: 'members'})

			returnObj = members

			res.json(returnObj)
		} catch (e) {
			res.json({error: e})
		}
	},

	'council': async (req, res) => {
		try {
			var councilType;
			var team;
			var image;
			var content;

			councilType = req.params.id
			image = await Static.findOne({key: 'council.' + councilType + '.image'})
			team = await Member.find({page: 'council.' + councilType})
			content = await Post.find({
				where: {page: 'council.' + councilType},
				limit: 10,
				sort: 'position ASC'
			})

			returnObj = {
				image: image.value,
				content: content,
				team: team,
				imageId: image.id
			}

			res.json(returnObj)
		} catch (e) {
			res.json({error: e})
		}
	},

	'activities': async (req, res) => {
		try {
			var activitiesType;

			activitiesType = req.params.id
			activities = await Post.find({
				where: {page: 'activities.' + activitiesType},
				limit: 10,
				sort: 'createdAt DESC'
			})


			returnObj = activities

			res.json(returnObj)
		} catch (e) {
			res.json({error: e})
		}
	},

	'footer': async (req, res) => {
		try {
			var footer

			footer = await Post.find({page: 'footer'})

			returnObj = footer

			res.json(returnObj)
		} catch (e) {
			res.json({error: e})
		}
	}

};

