const express=require("express");
const mongoose=require("mongoose");
const authRouter=require("./auth");
const cors=require('cors');
require('dotenv').config();
const app=express();
app.use(cors());

const PORT=process.env.PORT || 3000;
//const MONGO_URL= mongodb+srv://ved:admin@flutterauth.ovelesg.mongodb.net/?retryWrites=true&w=majority&appName=flutterAuth
const MONGO_URL=process.env.MONGO_URL
app.use(express.json());
app.use(authRouter);
app.get('/',(req,res)=>{
res.status(200).json({"msg":"hello"});
});
mongoose.connect(MONGO_URL).then(()=>{
    console.log("MongoDB Connected");
}).catch((e)=>{
    console.log("error connecting database",e);
})


app.listen(PORT,()=>{
console.log(`Server Listening on Port :`,PORT)
})