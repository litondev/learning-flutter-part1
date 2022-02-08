import { Sequelize } from "sequelize";

// import models
import ProductModel from "../models/product.js";

// import helpers
import FormatResponse from "../helpers/FormatResponse.mjs";

// import validators
import {ValidateProduct} from "../validators/ProductValidator.mjs";

import fs from "fs";

// function get All Products
export const ProductIndex = async (req, res) => {
    try {
        let filter = {
            order: [
                [req.query.order || 'id', (req.query.ordering === 'asc' ? 'asc' : 'desc')],
            ],
            attributes : ['id','title','stock','price'],
            limit : req.query.per_page || 10
       };

       if(req.query.search){
            filter.where = {            
                    [Sequelize.Op.and] : [{
                        [Sequelize.Op.or] : [
                            {
                                title : {
                                    [Sequelize.Op.regexp] : ".*" + req.query.search + ".*",
                                },                                          
                            },                           
                        ]
                    }]                           
            }
       }    

       const products = await ProductModel.findAll(filter);

       return res.json(products);
    } catch (error) {       
       return FormatResponse.Failed(error,res);
    }    
}
 
// function get single Product
export const ProductShow = async (req, res) => {
    try {

        const product = await ProductModel
            .findOne({
                where : {
                    id: req.params.id
                },
                attributes : ['id','title','stock','price'],
            })    

        if(!product){
            return res.status(401).json({
                "message" : "Not Found"
            });
        }

        return res.json(product);
    } catch (error) {
        return FormatResponse.Failed(error,res);
    }    
}
 
export const ProductCreate = async (req, res) => {
    try {                              
        let isNotValid = await ValidateProduct(req);

        if(isNotValid){
            return res.status(422).json({
                "message" : isNotValid.msg
            });
        }    

        if(req.file){
            req.body.photo = req.file.filename; 
        }
    
        await ProductModel.create(req.body)

        return res.json({
            "message" : true
        });
    } catch (error) {    
       return FormatResponse.Failed(error,res);
    }
}
 
// function Update Product
export const ProductUpdate = async (req, res) => {
    try {
        let isNotValid = await ValidateProduct(req);

        if(isNotValid){
            return res.status(422).json({
                "message" : isNotValid.msg
            });
        }    

        const product = await ProductModel          
            .findOne({
                where : {
                    id : req.params.id
                },  
                attributes : ['id','photo']
            });  

        if(!product) {            
            return res.status(404).json({
                message : "Not Found"
            })
        }
        
        if(req.file){                        
            req.body.photo = req.file.filename;             

            if(product.photo && product.photo != "default.png" && fs.existsSync("./assets/products/"+product.photo)){
                fs.unlinkSync("./assets/products/"+product.photo);
            }
        }

        await ProductModel.update(req.body, {
            where: {
              id: req.params.id
            }
        });

        return res.json({
            message : true
        });
    } catch (error) {        
        return FormatResponse.Failed(error,res);
    }
}
 
// function Delete Product
export const ProductDestroy = async (req, res) => {
    try {        
        const product = await ProductModel           
            .findOne({
                where : {
                    id : req.params.id
                },  
                attributes : ['id','photo']
            });    

        if(!product) {            
            return res.status(404).json({
                message: "Not Found"
            });
        }

        if(product.photo && product.photo != "default.png" && fs.existsSync("./assets/products/"+product.photo)){
            fs.unlinkSync("./assets/products/"+product.photo);
        }

        await ProductModel.destroy({
            where : {
                id: req.params.id
            }
        });

        return res.json({
            message : true
        });
    } catch (error) {    
        return FormatResponse.Failed(error,res);
    }
}