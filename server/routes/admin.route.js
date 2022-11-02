/*jshint esversion: 6 */


const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin.middleware');
const {authAdmin, getProducts, deleteProduct} = require('../controllers/admin.auth.controller');
adminRouter.post('/add-product', admin, authAdmin);
adminRouter.get('/get-products', admin, getProducts);
adminRouter.post('/delete-products', admin, deleteProduct);

module.exports = adminRouter;
