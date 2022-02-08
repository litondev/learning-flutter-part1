import { Sequelize } from 'sequelize';

try{
    const sequelize = new Sequelize(process.env.DB_DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
        host: process.env.DB_HOST,
        port : process.env.DB_PORT,
        dialect: process.env.DB_DB
    });

    await sequelize.authenticate();
        
    console.log("Success Conn");
}catch(err){
    console.log("Failed Conn: " + err.message);
}
