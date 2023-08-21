const express = require('express')
const User = require('../models/user')
const multer = require('multer')
const sharp = require('sharp')
const auth = require('../middleware/auth')

//Original Router
const router = new express.Router()

//Helpers
const upload = multer({
    limits: {
        fileSize: 100000000
    }
})


//Endpoints
//Create New User
router.post('/users', async (req, res) => {
    const user = new User(req.body)

    try {
        await user.save()

        res.status(201).send(user)

    }catch (err) {
        res.status(400).send(err)
    }
})

//Fetch User
router.get('/users', async (req, res) => {
    try {
        const users = await User.find({})

        res.send(users)

    }catch (err) {
        res.status(500).send(err)
    }
})

//Log In User
router.post('/users/login', async (req, res) => {
    try {
        const user = await User.findByCredentials(req.body.email, req.body.password)

        const token = await user.generateAuthToken()

        res.send({user, token})

    }catch (err) {
        res.status(500).send(err)
    }
})

//Delete User
router.delete('/users/:id', async (req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id)

        if(!user) {
            return res.status(400).send()
        }

        res.send()

    }catch (err) {
        res.status(500).send(err)
    }
})

//Fetch a single User
router.get('/users/:id', async (req, res) => {
    try {
        const _id = req.params.id

        const user = await User.findById(_id)

        if(!user) {
            return res.status(404).send()
        }

        res.send(user)
    }catch (err) {
        res.status(500).send(err)
    }
})

//Post User Profile Image
router.post('/users/me/avatar', auth, upload.single('avatar'), async (req, res) => {
    const buffer = await sharp(req.file.buffer).resize({width: 250, height: 250}).png().toBuffer()

    if(req.user.avatar != null) {
        req.user.avatar = null
        req.user.avatarExists = false
    }

    req.user.avatar = buffer
    req.user.avatarExists = true

    await req.user.save()

    res.send(buffer)
}, (error, req, res, next) => {
    res.status(400).send({error: error.message})
})

//Fetching the Profile Picture to Display
router.get('/users/:id/avatar', async (req, res) => {
    try {
        const user = await User.findById(req.params.id)

        if(!user || !user.avatar) {
            throw new Error('User Does not Exists or Does not have avatar')
        }

        res.set('Content-Type', 'image/jpg')

        res.send(user.avatar)
    }catch (err) {
        res.status(404).send(err)
    }
})

//Route for Following
router.put('/users/:id/followe', auth, async (req, res) => {
    if(req.user.id != req.params.id) {
        try {
            const user = await User.findById(req.params.id)
            if(!user.followers.includes(req.user.id)) {
                await user.updateOne({ $push: { followers: req.user.id } })
                await req.user.updateOne({ $push: { followings: req.params.id } })
                res.status(200).json("User has been Followed..")
            }else {
                res.status(403).json("You Already Follow This User..")
            }
        }catch (err) {
            res.status(500).json(err)
        }
    }else {
        res.status(403).json("You Can not Follow Yourself..")
    }
})

//Route for Unfollowing
router.put('/users/:id/unfollow', auth, async (req, res) => {
    if(req.user.id != req.params.id) {
        try {
            const user = await User.findById(req.params.id)

            if(user.followers.includes(req.user.id)) {
                await user.updateOne({ $pull: { followers: req.user.id } })
                await req.user.updateOne({ $pull: { followings: req.params.id } })
                res.status(200).json("The User Has Been Unfollowed..")
            }else {
                res.status(403).json("Can Not UnFollow, Because You Do Not Follow This User")
            }
        }catch (err) {
            res.status(500).json(err)
        }
    }else {
        res.status(403).json("You Can not Unfollow Yourself..")
    }
})


module.exports = router