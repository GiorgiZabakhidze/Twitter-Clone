const mongoose = require('mongoose')

const messageScheme = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },

    username: {
        type: String,
        required: true
    },

    mesSenderId: {
        type: String,
        required: true
    },

    mesReceiverId: {
        type: String,
        required: true
    },

    message: {
        type: String,
        required: true
    }
    
})

const message = mongoose.model('message', messageScheme)

module.exports = message