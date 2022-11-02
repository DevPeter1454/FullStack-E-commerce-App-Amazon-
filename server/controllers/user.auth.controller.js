/*jshint esversion: 9 */


const userModel = require("../models/user.models");
const bcryptjs = require("bcryptjs");
const jwt  = require('jsonwebtoken');
const registerUser = (req, res) => {
    const { name, email, password } = req.body;
    console.log(name, email, password);
    userModel.findOne({ email: email }, (err, user) => {
      if(err){
          return res.status(500).send({error: 'Server error'});
      }else{
          if(user){
              return res.status(400).send({message: 'Email already exists', status: false});
          }else{
              let saltRound = 10;
              bcryptjs.hash(password, saltRound, (err, hash)=>{
              if(err){
                  return res.status(500).send({error: 'Server error'});
              }else{
              let user = new userModel({ name, email, password:hash });
              user.save((err) => {
               if (err) {
                  console.log(`err.message ${err.message}`);
                  if ( err.message.includes( "User validation failed: email: Please enter a valid email address")){
                      return  res.status(400).json({ message: "Email Address is not valid",status: false});
                   } else if ( err.message.includes( "User validation failed: password: " )) {
                       return res.status(400).json({ message: "Password must be at least 6 characters long",status: false});
                  } else {
                  return res.status(400).json({ message: "Error saving user in database" });
                  }
              }else{
                  return res.status(200).json({ message: "Signup success!", status: true , user});
           }
          });
          }
      });
          }
      }
      });};

const loginUser = (req, res) => {
    const { email, password } = req.body;
     console.log(req.body);
    userModel.findOne({ email: email }, (err, user) => {
      if (err) {
        return res.status(500).send({ error: "Server error" });
      } else {
        if (user) {
          bcryptjs.compare(password, user.password, (err, result) => {
            if (err) {
              return res.status(500).send({ error: "Server error" });
            } else {
              if (result) {
                jwt.sign({id:user._id }, "passwordKey", (err, token) => {
                    if (err) {
                        return res.status(500).send({ error: "Server error" });
                    } else {
                        console.log(user);
                        return res.status(200).json({ message: "Login success!", status: true, token, ...user._doc});
                    }
                });
                // return res.status(200).json({ message: "Login success!", status: true, user });
              } else {
                return res.status(400).send({ message: "Incorrect password", status: false });
              }
            }
          });
        } else {
          return res.status(400).send({ message: "Invalid email", status: false });
        }
      }
    });
  };


  const verifyUser = (req, res) => {
    const token = req.header('x-auth-token');
    if(!token){
      return res.json(false);
    }
    jwt.verify(token, "passwordKey", (err, decoded) => {
        if(err){
          return res.status(500).send({ error: "Server error" });
        }else 
          if(!decoded){
          return res.json(false);
          }else{
            const user = userModel.findById(decoded.id, (err, user)=>{
               if(err){
                  return res.status(500).send({ error: "Server error" });
               }else
                if(!user){
                  return res.json(false);
                }else{
                  return res.json(true);
                }
            });
          }
    });
  };
  
  const getUserData = (req, res) =>{
    console.log("getUserData");
     userModel.findById(req.user, (err, user)=>{
        if(err){
          return res.status(500).send({ error: "Server error" });
        }else{
          return res.json({...user._doc , token: req.token});
        }
     });
  };
module.exports = { registerUser, loginUser , verifyUser , getUserData };