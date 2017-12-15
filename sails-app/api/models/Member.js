/**
 * Member.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  schema: true,

  attributes: {
    name: {
      type: 'string',
      required: true
    },
    type: {
      type: 'string',
      required: true
    },
    email: {
      type: 'string',
      required: true
    },
    contact: {
      type: 'string',
      required: true
    },
    image: {
      type: 'string',
      required: true
    },
    position: {
      type: 'string',
      required: true
    },
    page: {
      type: 'string',
      required: true
    }
  }
};
