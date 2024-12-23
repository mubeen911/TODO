import mongoose from "mongoose";

const dbConnection=async()=>{
    try {
         const conn= await mongoose.connect("mongodb+srv://zeshan:1234@zeshan.at03m.mongodb.net/")
         if(conn){
            console.log("db connected : with host name: ", conn.connection.host)
         }else{
            console.log("error conneting monogodb")
            process.exit(1)
         }
    } catch (error) {
        console.log( error ,error.message)
    }


}

export default dbConnection; 