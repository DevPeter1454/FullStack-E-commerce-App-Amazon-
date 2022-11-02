/*jshint esversion: 6 */

const jwt = require("jsonwebtoken");
const userModel = require('../models/user.models');


const auth = (req, res, next)=>{
    try {
        const token = req.header("x-auth-token");
        if (!token)
          return res.status(401).json({ msg: "No auth token, access denied" });
    
        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
          return res
            .status(401)
            .json({ msg: "Token verification failed, authorization denied." });
    
        req.user = verified.id;
        req.token = token;

        const {id} = req.user;
    userModel.findById(id, (err,user)=>{
        if(err){
            res.status(500).send({error: err.message});
        }else{
            if(user){
                if(user.type == 'user' || user.type == 'seller'){
                    return res.status(401).send({error: 'Unauthorized'});
                }else if(user.type == 'admin'){
                    res.json({ message: 'Authorized'});
                }
            // }else{
            //     return res.json(false);
            }
            // else{
            //     return res.json(false);
            // }
        }
    });
        next();
      } catch (err) {
        res.status(500).json({ error: err.message });
      }
};

module.exports = auth;
