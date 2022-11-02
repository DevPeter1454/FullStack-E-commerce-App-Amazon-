/*jshint esversion: 6 */

const mongoose = require('mongoose');
const ratingSchema = require('./rating.model');
const productSchema = mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true,
    },
    description:{
        type:String,
        required:true,
        trim:true,
    },
    images:[
        {
            type:String,
            required:true,
        }
    ],
    quantity: {
        type:Number,
        required:true,
    },
    price:{
        type: Number,
        required: true,
    },
    category: {
        type: String, 
        required:true,
    },
    ratings: [
        ratingSchema
    ]

});

const productModel = mongoose.model('product', productSchema);

module.exports = {productModel, productSchema};
