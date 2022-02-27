import { check,validationResult } from "express-validator";

export const ValidateProductStock = (req) => {
	return (async (req) => {
	
		await check('stock')
		
			.isFloat()
			.withMessage("Stock tidak valid")

			.trim()
			.escape()
			.run(req);

		return !validationResult(req).isEmpty()
			? validationResult(req).array()[0]
			: false;
	})(req)
}