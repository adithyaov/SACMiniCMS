/**
 * Post.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  schema: true,

  attributes: {
    title: {
      type: 'string',
      required: true
    },
    content: {
      type: 'json',
      required: true
    },
    link: {
      type: 'string'
    },
    image: {
      type: 'string'
    },
    page: {
      type: 'string',
      required: true
    },
    position: {
      type: 'float',
      required: true,
      defaultsTo: 10
    }
  }
};

