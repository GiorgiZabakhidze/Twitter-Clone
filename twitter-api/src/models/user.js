const mongoose = require('mongoose')
const validator = require('validator')
const bcrypt = require('bcryptjs')

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
        type: String,
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

//The relationship bewteenthe tweets and user
userSchema.virtual('tweets', {
    ref: 'Tweet',
    localField: '_id',
    foreignField: 'user'
})

//To delete Password prior to Get
userSchema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    // delete userObject.password

    return userObject
}

//Hash The Password
userSchema.pre('save', async function(next) {
    const user = this 

    if(user.isModified('password')) {
        user.password = await bcrypt.hash(user.password, 8)
    }

    next()
})

//Authenticate User
userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({email})

    if(!user) {
        throw new Error('Email Does Not Exists')
    }

    const isMatch = await bcrypt.compare(password, user.password)

    if(!isMatch) {
        throw new Error('Incorrect Password')
    }

    return user

}

const User = mongoose.model('User', userSchema)

module.exports = User