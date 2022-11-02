/*jshint esversion: 6 */


const express = require('express');
const app = express();
const mongoose = require('mongoose');
require('dotenv').config();



const authRouter = require('./routes/auth.route');
const adminRouter = require('./routes/admin.route');
const productsRouter = require('./routes/product.route');
const userRouter = require('./routes/user.route');
const PORT = process.env.PORT || 3000;
const URI = process.env.MONGO_URI;

mongoose.connect(URI,(err)=>{
    if(err){
        console.log(err);
    }else{
        console.log('Connected to MongoDB');
    }
});
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/auth', authRouter);
app.use('/admin', adminRouter);
app.use('/products', productsRouter);
app.use('/user', userRouter);


app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`Server is running on port ${PORT}`);
});