const jwt = require("jsonwebtoken");

const middle_auth = (req,res,next)=>{
    try {
        const token = req.header("auth-token");
        if (!token) return res.status(401).json({msg:'UnAuthorized Token'});
        const verified =jwt.verify (token,"passwordKey");
        if (!verified) return res.status(401).json({msg: ' Token Authorization Failed'});

        req.user = verified.id;
        req.token = token;

        next();
        
    } catch (error) {
        res.status(500).json({error: error.message});
        
    }
    

}

module.exports = middle_auth;