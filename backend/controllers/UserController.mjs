import { Sequelize } from "sequelize";

// import models
import UserModel from "../models/user.js";

// import helpers
import FormatResponse from "../helpers/FormatResponse.mjs";

// import validators
import {ValidateUser} from "../validators/UserValidator.mjs";

// import bcrypt
import {BcryptHash} from "../helpers/Bcrypt.mjs";

import fs from "fs";

// function get All Users
export const UserIndex = async (req, res) => {
    try {
       let filter = {
            order: [
                [req.query.order || 'id', (req.query.ordering === 'asc' ? 'asc' : 'desc')],
            ],
            attributes : ['id','username','email'],
            limit : req.query.per_page || 10
       };

       if(req.query.search){
            filter.where = {            
                    [Sequelize.Op.and] : [{
                        [Sequelize.Op.or] : [
                            {
                                username : {
                                    [Sequelize.Op.regexp] : ".*" + req.query.search + ".*",
                                },                                          
                            },
                            {
                                email : {
                                    [Sequelize.Op.regexp] : ".*" + req.query.search + ".*"
                                }                                          
                            }
                        ]
                    }]                           
            }
       }

       const users = await UserModel.findAll(filter)   

       return res.json(users);
    } catch (error) {       
       return FormatResponse.Failed(error,res);
    }    
}
 
// function get single User
export const UserShow = async (req, res) => {
    try {

        const user = await UserModel
            .findOne({
                where : {
                    id: req.params.id
                },
                attributes : ['id','email','photo','username'],    
            })            

        if(!user){
            return res.status(401).json({
                "message" : "Not Found"
            });
        }

        return res.json(user);
    } catch (error) {
        return FormatResponse.Failed(error,res);
    }
     
}
 
export const UserCreate = async (req, res) => {
    try { 

        let isNotValid = await ValidateUser(req);

        if(isNotValid){
            return res.status(422).json({
                "message" : isNotValid.msg
            });
        }    
        
        let payload = req.body;

        if(req.file){
            req.body["photo"] = req.file.filename; 
        }

        payload["password"] = BcryptHash(payload["password"]);

        await UserModel.create(payload);

        return res.json({
            "message" : true
        });
    } catch (error) {    
       return FormatResponse.Failed(error,res);
    }
}
 
// function Update User
export const UserUpdate = async (req, res) => {
    try {
        let isNotValid = await ValidateUser(req);

        if(isNotValid){
            return res.status(422).json({
                "message" : isNotValid.msg
            });
        }    
        
        const user = await UserModel          
            .findOne({
                where : {
                    id : req.params.id
                },
                attributes : ['id','photo']
            });    

        if(!user) {            
            return res.status(404).json({
                message : "Not Found"
            })
        }
                
        let payload = req.body;

        if(req.file){                        
            req.body["photo"] = req.file.filename;             

            if(user.photo && user.photo != "default.png"){
                fs.unlinkSync("./assets/users/"+user.photo);
            }
        }

        if(payload["password"]){
            payload["password"] = BcryptHash(payload["password"]);
        }    

        await UserModel.update(payload, {
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
 
// function Delete User
export const UserDestroy = async (req, res) => {
    try {        
        const user = await UserModel           
            .findOne({
                where : {
                    id : req.params.id
                },  
                attributes : ['id','photo']
            });    

        if(!user) {            
            return res.status(404).json({
                message: "Not Found"
            });
        }
    
        if(user.photo && user.photo != "default.png"){
            fs.unlinkSync("./assets/users/"+user.photo);
        }

        await UserModel.destroy({
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