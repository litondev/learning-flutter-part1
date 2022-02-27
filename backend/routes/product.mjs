// import express
import express from "express";
import ProductUploadMiddleware from "../uploads/Product.mjs";

// import controllers
import { 
    ProductIndex, 
    ProductShow, 
    ProductCreate, 
    ProductUpdate,
    ProductDestroy,
    ProductUpdateStock
} from "../controllers/ProductController.mjs";
 
    // express router
const ProductRoute = express.Router();
 

// Route get All Products
ProductRoute.get('/', ProductIndex);
// Route get single Product
ProductRoute.get('/:id', ProductShow);
// Route CREATE Product
ProductRoute.post('/', ProductUploadMiddleware,ProductCreate);
// Route UPDATE Product
ProductRoute.put('/:id',ProductUploadMiddleware,ProductUpdate);
// Route DELETE Product
ProductRoute.delete('/:id', ProductDestroy);
// Route PATCH Product
ProductRoute.patch("/stock/:id",ProductUpdateStock);

// export router
export default ProductRoute;