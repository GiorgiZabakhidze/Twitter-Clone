const express = require('express')
const multer = require('multer')
const sharp = require('sharp')
const Tweet = require('../models/tweet')
const auth = require('../middleware/auth')

//New Router
const router = new express.Router()

//Helper Functions
const upload = multer({
    limits: {
        fileSize: 100000000
    }
})

//Post Tweet
router.post('/tweets', auth, async (req, res) => {
    const tweet = new Tweet({
        ...req.body,
        user: req.user._id
    })

    try {
        await tweet.save()
        res.status(201).send(tweet)
    }catch (err) {
        res.status(400).send(err)
    }
})

//Upload Image to Tweet route
router.post('/uploadTweetImage/:id', auth, upload.single('upload'), async (req, res) => {
    const tweet = await Tweet.findOne({ _id: req.params.id})

    if(!tweet) {
        throw new Error('Tweet does not exists')
    }

    const buffer = await sharp(req.file.buffer).resize({width: 350, height: 350}).png().toBuffer()

    tweet.image = buffer

    await tweet.save()

    res.send()

}, (error, req, res, next) => {

    res.status(400).send({error: error.message})

})

//Fetch Tweet Image
router.get('/tweets/:id/image', async (req, res) => {
    try {
        const tweet = await Tweet.findById(req.params.id)

        if(!tweet && !tweet.image) {
            throw new Error('Image Does Not Exists')
        }

        res.set('Content-Type', 'image/jpg')

        res.send(tweet.image)

    }catch {
        res.status(404).send(err)
    }
})

//Fetch All Tweets
router.get('/tweets', async (req, res) => {
    try {
        const tweets = await Tweet.find({})

        res.status(200).send(tweets)
    }catch (err) {
        res.status(500).send(err)
    }
})

module.exports = router;

