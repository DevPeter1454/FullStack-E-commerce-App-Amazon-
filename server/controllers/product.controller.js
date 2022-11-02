/*jshint esversion: 6 */

const {productModel} = require('../models/product.model');


const getCategoryProducts = (req,res)=>{
    try{
        console.log(req.query.category);
        productModel.find({category: req.query.category}, (err, products) => {
            if (err) {
                console.log(err);
                res.status(500).send({ error: err.message});
            }else{
                res.json(products);
            }
        });
    }catch(e){
        console.log(e);
        res.status(500).send({error: e.message});
    }
};

const getSearchProducts = (req,res)=>{
    try{
        console.log(req.query.searchQuery);
        productModel.find({name: {$regex: req.query.searchQuery, $options: "i"}  }, (err, products) => {
            if (err) {
                console.log(err);
                res.status(500).send({ error: err.message});
            }else{
                res.json(products);
            }
        });

    }catch(e){

    }
};

const rateProduct = (req, res)=>{
    try{
        const {id, rating } = req.body;
        console.log(req.body);
        productModel.findById(id, (err, product)=>{
            if(err){
                res.status(500).send({error: err.message});
            }else{
                // console.log(product);
                for(let i = 0; i < product.ratings.length; i++){
                    if(product.ratings[i].userId == req.user){
                        product.ratings.splice(i, 1);
                        break;
                    }
                }
                const ratingSchema = {
                    userId: req.user,
                    rating: rating,
                };

                product.ratings.push(ratingSchema);
                product.save((err, product)=>{
                    if(err){
                        res.status(500).send({error: err.message});
                    }else{
                console.log(product);

                        res.json(product);
                    }
                });

            }
        });

    }catch(e){
        res.status(500).send({error: err.message});
    }
};

const getDealOfTheDay = (req, res)=>{
    try{    
        productModel.find({}, (err, products)=>{
            if(err){
        res.status(500).send({error: e.message});
            }else{
            products =  products.sort((a, b)=>{
                    let aSum = 0;
                    let bSum = 0;
                    for(let i = 0; i < a.ratings.length; i++){
                        aSum += a.ratings[i].rating;
                    }
                    for(let i = 0; i < b.ratings.length; i++){
                        bSum += b.ratings[i].rating;
                    }
                    return aSum < bSum ? 1 : -1;
                });
            res.json(products[0]);
            }
        });

    }catch(e){
        res.status(500).send({error: e.message});
    }
};

module.exports = {getCategoryProducts, getSearchProducts, rateProduct, getDealOfTheDay};