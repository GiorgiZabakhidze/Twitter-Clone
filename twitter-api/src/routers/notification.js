const express = require('express')
const auth = require('../middleware/auth')
const Notification = require('../models/notification')

const router = new express.Router()

router.post('/notification', auth, async (req, res) => {
    const notification = new Notification({
        ...req.body,
        user: req.user._id
    })

    try {
        await notification.save()

        res.status(201).send(notification)
        
    }catch (err) {
        res.status(400).send(err)
    }
})