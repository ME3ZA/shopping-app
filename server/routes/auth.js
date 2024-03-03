const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const e = require("express");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const middle_auth = require("../middlewares/middle_auth");

authRouter.post("/api/signup",async(req,res)=> {
    try {const {name,email,password} = req.body;
    
    const existingUser = await User.findOne({email});
     if (existingUser){
        res.status(400).json({msg: "Email Already Exists"});
     }

     hashedPassword = await bcryptjs.hash(password,8);

     let user = new User ({
        name,
        email,
        password:hashedPassword,
     });
     user = await user.save();
     res.json(user);
      
    } catch (e) {
      res.status(500).json({error: e.message})
      
    }
});

authRouter.post("/api/signin",async(req,res)=>{
   try {const {email,password} = req.body;
   const signInUser = await User.findOne({email});
     if (!signInUser){
        res.sendStatus(400).json({msg: "Email doesn't exist, please enter a valid email"});
     }
     const isMatch = await bcryptjs.compare(password,signInUser.password);
     if(!isMatch){
      res.sendStatus(400).json({msg : "Incorrect Password"});
     }
     const token = jwt.sign({id:signInUser._id},"passwordKey");
     res.json({token,...signInUser._doc})
      
   } catch (e) {
      res.status(500).json({error: e.message})
   }
});


authRouter.post("/tokenIsValid",async(req,res)=>{
  try {
    const token = req.header("auth-token");
   if(!token) return res.json(false);
   const verified = jwt.verify(token,"passwordKey");
   if (!verified) return res.json (false);
  const checkUser = await User.findById(verified.id);
  if (!checkUser) return res.json (false);
   res.json(true);
  } catch (error) {
     res.status(500).json({error: error.message})
  }
});

authRouter.get("/",middle_auth, async(req,res)=>{
   const getUser = await User.findById(req.user);
   res.json({...getUser._doc, token: req.token});
});


module.exports = authRouter;