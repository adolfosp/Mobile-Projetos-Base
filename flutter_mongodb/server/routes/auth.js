const express = require('express');
const User = require('../models/user');
const bcrypytjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');

authRouter.post('/api/signup', async (req, res) =>{
    try {
        const {firstName, lastName, email, password} = req.body;
        const existingUser = await User.findOne({email});
        
        if(existingUser){
            return res.status(400).json({msg: 'Email já existente '});
        }

        const hashedPassword = await bcrypytjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            firstName,
            lastName,
        });

        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

authRouter.post('/api/login', async(req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg: 'Email não encontrado'})
        }

        const isMatch = await bcrypytjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: 'Senha ou e-mail não validos'})
        }

        const token = jwt.sign({id: user._id}, 'passworKey');
        res.json({token, ...user._doc});

    }catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = authRouter;