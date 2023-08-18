const express = require('express')
require('./db/mongoose')

const app = express()

const userRouter = require('./routers/user')

const port = process.env.PORT || 3000

app.use(express.json())
app.use(userRouter)

app.listen(port, () => {
    console.log("The Server Is Up On Port" + port)
})