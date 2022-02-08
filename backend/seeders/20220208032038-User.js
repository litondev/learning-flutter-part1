'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    const { BcryptHash } = await import('../helpers/Bcrypt.mjs');
 
    var users = [];

  	for(let i=0;i<100;i++){
  	 users.push({
        username: `user${i}`,      
        email: `user${i}@gmail.com`,
        password: BcryptHash("12345678")
      })
  	}

    await queryInterface.bulkInsert('users', users); 	
  },

  async down (queryInterface, Sequelize) {  }
};
