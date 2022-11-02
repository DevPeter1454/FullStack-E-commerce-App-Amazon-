/*jshint esversion: 6 */

const express = require('express');
const productRouter = express.Router();
const {getCategoryProducts, getSearchProducts, rateProduct, getDealOfTheDay} = require('../controllers/product.controller');
const auth = require("../middlewares/auth.middleware");


productRouter.get('/get-category-products',auth, getCategoryProducts);
productRouter.get('/search',auth, getSearchProducts);
productRouter.post('/rate', auth , rateProduct);
productRouter.get('/deal-of-the-day', auth, getDealOfTheDay);


module.exports = productRouter;
