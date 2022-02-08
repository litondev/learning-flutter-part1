'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      username: {
        type: Sequelize.STRING(50),
        unique: true
      },
      email: {
        type: Sequelize.STRING(50),
        unique : true
      },
      password: {
        type: Sequelize.TEXT
      },
      photo: {
        type: Sequelize.TEXT,
        defaultValue : 'default.png'
      },
      createdAt: {
        allowNull: true,
        type: Sequelize.DATE,
        defaultValue : Sequelize.fn('NOW')
      },
      updatedAt: {
        allowNull: true,
        type: Sequelize.DATE,
        defaultValue : Sequelize.fn('NOW')
      }
    },{
      indexes: [
        {
          unique : true,
          fields: ['email','username']
        }
      ]
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('users');
  }
};