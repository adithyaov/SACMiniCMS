/**
 * Sails Seed Settings
 * (sails.config.seeds)
 *
 * Configuration for the data seeding in Sails.
 *
 * For more information on configuration, check out:
 * http://github.com/frostme/sails-seed
 */
module.exports.seeds = {
	static: [
		{
			key: 'home.imageBig',
			value: 'none'
		},
		{
			key: 'home.directorName',
			value: 'Sunil Kumar'
		},
		{
			key: 'home.directorQuote',
			value: 'This is a quote'
		},
		{
			key: 'council.sports.image',
			value: 'none'
		},
		{
			key: 'council.technical.image',
			value: 'none'
		},
		{
			key: 'council.cultural.image',
			value: 'none'
		}
	]
}
