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

//Fetch Certain User's Messages
router.get('/messages/:id', async (req, res) => {
    try {
        const messages = await Message.find({ mesReceiverId: req.params.id })

        res.status(200).send(messages)
    }catch (err) {
        res.status(500).send(err)
    }
})

module.exports = router