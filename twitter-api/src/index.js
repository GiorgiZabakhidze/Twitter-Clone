const express = require('express')
require('./db/mongoose')
const userRouter = require('./routers/user')
const tweetRouter = require('./routers/tweet')

const app = express()

const port = process.env.PORT || 3000

app.use(express.json())
app.use(userRouter)
app.use(tweetRouter)

app.listen(port, () => {
    console.log("The Server Is Up On Port " + port)
})