const {DataTypes} = require("sequelize");
const DB = require("../configs/database.js");

const Product = DB.define("products",{
  title : {
    type: DataTypes.STRING
  },
  price : {
  	type: DataTypes.INTEGER
  },
  stock : {
  	type: DataTypes.TEXT
  },
  photo : {
    type: DataTypes.STRING(50)
  },
  description : {
    type : DataTypes.TEXT
  }
});

module.exports = Product;