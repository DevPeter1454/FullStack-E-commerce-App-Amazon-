/*jshint esversion: 9 */


const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth.middleware');
const {productModel} = require('../models/product.model');
const userModel = require('../models/user.models');
userRouter.post('/add-to-cart', auth , (req, res) => {
    try{
       const {id} = req.body;
       productModel.findById(id, (err, product) =>{
        if(err){
                return res.status(500).send({err: err.message});
       }else{
        userModel.findById(req.user, (err, user) =>{
            if(err){
                return res.status(500).send({err: err.message});
            }else{
                if(user.cart.length == 0){
                    user.cart.push({product, quantity: 1});
                }else{
                    let isProductFound = false;
                    for(let i=0; i<user.cart.length; i++){
                        if(user.cart[i].product._id.equals(product._id)){
                            isProductFound = true;

                    }
                }
                if(isProductFound){
                    let newProduct = user.cart.find((nProduct)=>{
                        return nProduct.product._id.equals(product._id);
                    });
                    newProduct.quantity += 1;
                }else{
                    user.cart.push({product, quantity: 1});
                }
            }
            user.save((err)=>{
                res.json(user);
            });
        }});
       }
    
    });
    }catch(e){
        res.status(500).send({error: e.message});
    }
});
userRouter.delete('/remove-from-cart/:id', auth , (req, res) => {
    try{
       const {id} = req.params;
    //    console.log(id);
       productModel.findById(id, (err, product) =>{
        if(err){
                return res.status(500).send({err: err.message});
       }else{
        userModel.findById(req.user, (err, user) =>{
            if(err){
                return res.status(500).send({err: err.message});
            }else{
                
                    
                    for(let i=0; i<user.cart.length; i++){
                        if(user.cart[i].product._id.equals(product._id)){
                            if(user.cart[i].quantity ==1){
                                user.cart.splice(i, 1);
                            }else{
                                user.cart[i].quantity -= 1;
                            }

                    }
                }
            
            user.save((err)=>{
                res.json(user);
            });
        }});
       }
    
    });
    }catch(e){
        res.status(500).send({error: e.message});
    }
});

module.exports = userRouter;
