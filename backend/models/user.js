const {DataTypes} = require("sequelize");
const DB = require("../configs/database.js");

const User = DB.define("users",{
  username : {
    type: DataTypes.STRING(50)
  },
  email : {
  	type: DataTypes.STRING(50)
  },
  password : {
  	type: DataTypes.TEXT
  },
  photo : {
    type: DataTypes.STRING(50)
  }
});

module.exports = User;