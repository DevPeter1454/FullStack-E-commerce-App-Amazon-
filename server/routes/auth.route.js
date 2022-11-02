/*jshint esversion: 6 */


const express = require("express");
const authRouter = express.Router();
const { registerUser, loginUser, verifyUser, getUserData  } = require("../controllers/user.auth.controller");
const auth = require("../middlewares/auth.middleware");
authRouter.post("/api/signup", registerUser); 
authRouter.post("/api/login", loginUser);
authRouter.post("/tokenIsValid", verifyUser);
authRouter.get('/getdata', auth, getUserData);
module.exports = authRouter;
