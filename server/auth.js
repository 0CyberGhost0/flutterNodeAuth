const express=require("express");
const authRouter=express.Router();
const bcrypt=require("bcryptjs");
const User = require("./models/userModel");
const jwt=require("jsonwebtoken");
const auth=require('./middleware/auth');
authRouter.post('/api/signup',async (req,res)=>{
    try {
        const {name,email,password}=req.body;
        const exisitingUser=await User.findOne({email:email});
        if(exisitingUser){
            return res.status(400).json({error:"User already Exists"});
        }
        const salt=await bcrypt.genSalt(10)
        const hashedPassword=await bcrypt.hash(password,salt);
        let newUser=new User({
            name,
            email,
            password: hashedPassword,
        });
        newUser=await newUser.save();
        res.status(200).json(newUser);
        
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});
authRouter.post('/api/signin',async (req,res)=>{
    try {
        const {email,password}=req.body;
        const exisitingUser=await User.findOne({email});
        if(!exisitingUser){
            return res.status(400).json({error:"User doesnt Exist"});
        }
        const isMatch=await bcrypt.compare(password,exisitingUser.password);
        if(!isMatch){
            return res.status(400).json({error:"Incorrect Password"});
        }
        const token=jwt.sign({id: exisitingUser._id},"password");
        res.status(200 ).json({token,...exisitingUser._doc});

        
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
})
authRouter.post('/tokenIsValid',async (req,res)=>{
    try{
        const token=req.header('x-auth-token');
        if(!token) return res.json(false);
        const verified=jwt.verify(token,'password');
        if(!verified) return res.json(false);
        const user=await User.findById(verified.id);
        if(!user) return res.json(false);
        res.json(true);

    }catch(e){
        res.status(500).json({error:e.message});
    }
})
authRouter.get('/',auth,async(req,res)=>{
    const user=await User.findById(req.user);
    res.json({...user._doc,token:req.token});
});
module.exports=authRouter;