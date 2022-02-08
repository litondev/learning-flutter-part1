import { check,validationResult } from "express-validator";
import { Sequelize } from "sequelize";
import UserModel from "../models/user.js";

export const ValidateUser = (req) => {
	return (async (req) => {
		await check('username')

			.not()
			.isEmpty()
			.withMessage("Username harus diisi")

			.isLength({max : 20})
			.withMessage("Username terlalu panjang")

			.trim()
			.escape()
			.run(req);

			await check('email')			

				.not()
				.isEmpty()
				.withMessage("Email harus diisi")

				.custom(value => {				
					let payload = {
						where : {
							email :  value,							
						}
					}

					if(req.method == "PUT" || req.method == "put"){
						payload.where.id = {
							[Sequelize.Op.not]: req.params.id						
						}
					}

					return UserModel.findOne(payload)				
					.then(user => {
						if(user){
							return Promise.reject("Email telah terpakai")
						}
					})
				})

				.isLength({max : 20})
				.withMessage("Email terlalu panjang")

				.trim()
				.escape()
				.run(req);
		

		if(req.method == "POST" || req.method == "post"){
			await check('password')

				.not()
				.isEmpty()
				.withMessage("Password harus diisi")

				.isLength({min : 8})
				.withMessage("Password terlau pendek")

				.trim()
				.escape()
				.run(req);
		}

		return !validationResult(req).isEmpty()
			? validationResult(req).array()[0]
			: false;
	})(req)
}