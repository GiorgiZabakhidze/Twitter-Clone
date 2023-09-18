const express = require('express')
const auth = require('../middleware/auth')
const Message = require('../models/messages')

const router = new express.Router()

//Send a Message To Certain User
router.post('/messages', auth, async (req, res) => {
    const message = new Message({
        ...req.body,
        user: req.user._id
    })

    try {
        await message.save()

        res.status(200).send(message)
    }catch (err) {
        res.status(400).send(err)
    }
})