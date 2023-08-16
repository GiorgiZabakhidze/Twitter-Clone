const express = require('express')
require('./db/mongoose')

const app = express()

const port = process.env.PORT || 3000

app.listen(port, () => {
    console.log("The Server Is Up On Port" + port)
})