const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const authRoute =  require('./routes/auth');

const app = express();
app.use(bodyParser.json());
app.use(authRoute);

mongoose.connect('', {autoIndex: false}).then(() => {
    app.listen(3000);
    console.log('Conectou na porta');
}).catch(err => {
    console.log(err);
});