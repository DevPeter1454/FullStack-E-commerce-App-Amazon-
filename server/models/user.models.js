/*jshint esversion: 6 */


const mongoose = require('mongoose');
const {productSchema} = require('../models/product.model');
const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value)=>{
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        }
    },
    password: {
        type: String,
        required: true,
        trim: true,
        validate: (value)=>{
            return value.length >= 6;
        },
        message: 'Password must be at least 6 characters long',
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true
        },
        }
    ],
});

const userModel = mongoose.model('User', userSchema);

module.exports = userModel;