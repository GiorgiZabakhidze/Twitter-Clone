const mongoose = require('mongoose')
const validator = require('validator')

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },

    username: {
        type: String,
        required: true,
        trim: true,
        unique: true
    },

    email: {
        tyoe: String,
        required: true,
        trim: true,
        unique: true,
        lowercase: true,
        validate(value) {
            if (!validator.isEmail(value)) {
                throw new Error('Invalid Email')
            }
        }
    },

    password: {
        type: String,
        required: true,
        minlength: 7,
        trim: true,
        validator(value) {
            if (value.toLowerCase().includes('password')) {
                throw new Error('Password Can not Contain "password')
            }
        }
    },

    avatar: {
        type: Buffer
    },

    avatarExists: {
        type: Boolean
    },

    bio: {
        type: String,
    },

    website: {
        type: String
    },

    location: {
        type: String
    },

    followers: {
        type: Array,
        default: []
    },

    following: {
        type: Array,
        default: []
    }
})

const User = mongoose.model('User', userSchema)

module.exports = User