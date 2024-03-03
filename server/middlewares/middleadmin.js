const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin =  async (req,res,next)=> {
    try {
        const token = req.header("auth-token");
        if (!token) return res.status(401).json({msg:'UnAuthorized Token'});
        const verified =jwt.verify (token,"passwordKey");
        if (!verified) return res.status(401).json({msg: ' Token Authorization Failed'});

        const user = await User.findById(verified.id);
        if (user.type == "user" || user.type == "seller"){
            return res.status(401).json({msg : "UnAuthorized admin token"})
        }


        req.user = verified.id;
        req.token = token;

        next();
        
    } catch (error) {
        res.status(500).json({error: error.message});
        
    }
}

module.exports = admin;