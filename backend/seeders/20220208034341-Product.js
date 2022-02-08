'use strict';

module.exports = {
  async up (queryInterface, Sequelize) { 
    var products = [];

  	for(let i=0;i<100;i++){
  	 products.push({
        title : `title${i}`,
        price : parseFloat(1000 * parseInt(i)),
        stock : parseInt(i),
      })
  	}

    await queryInterface.bulkInsert('products', products); 	
  },

  async down (queryInterface, Sequelize) {}
};
