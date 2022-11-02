/*jshint esversion: 6 */


const {productModel} = require('../models/product.model');


const authAdmin = (req, res) => {
    try{
        const {name , description, images , quantity, price, category} = req.body;
        let product = new productModel({name, description, images, quantity, price, category});
        product.save((err, product) => {
            if (err) {
                res.status(500).send({ error: err.message});
            }else{
                res.json(product);
            }
        });
    }catch(e){
        res.status(500).send({error: e.message});
    }
};

const getProducts = (req,res)=>{
    try{
        productModel.find({}, (err, products) => {
            if (err) {
                res.status(500).send({ error: err.message});
            }else{
                res.json(products);
            }
        });
    }catch(e){
        res.status(500).send({error: e.message});
    }
};

const deleteProduct=(req,res)=>{
    const {id} = req.body;
    try{
        productModel.findByIdAndDelete(id,(err, products) => {
            if(err){
                res.status(500).send({ error: err.message});
            }else{
                res.json({message: 'Product deleted successfully'});
            }
        });

    }catch(e){
        res.status(500).send({error: e.message});
    }
};


module.exports = {authAdmin, getProducts, deleteProduct};