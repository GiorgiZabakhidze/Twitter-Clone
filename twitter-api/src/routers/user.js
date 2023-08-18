const express = require('express')
const User = require('../models/user')
//Original Router
const router = new express.Router()

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


module.exports = router