const express = require('express')
const auth = require('../middleware/auth')
const Notification = require('../models/notification')

const router = new express.Router()

//Create Notification
router.post('/notifications', auth, async (req, res) => {
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

//Fetch Notifications
router.get('/notifications', async (req, res) => {
    try {
        const notifications = await Notification.find({})
        
        res.send(notifications)
    }catch (err) {
        res.status(500).send(err)
    }
})

//Fetch a Single User's Notifications
router.get('/notifications/:id', async (req, res) => {
    try {
        const notifications = await Notification.find({ notReceiverId: req.params.id})
        
        res.send(notifications)
    }catch (err) {
        res.status(500).send(err)
    }
})

module.exports = router