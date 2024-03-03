const express = require("express");
const mongoose = require("mongoose"); // Import mongoose
const PORT = 3000;
const app = express();
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");
const DB = "mongodb://ahmedrush96:himynameisoj1@ac-wkgxbtm-shard-00-00.ttuwv83.mongodb.net:27017,ac-wkgxbtm-shard-00-01.ttuwv83.mongodb.net:27017,ac-wkgxbtm-shard-00-02.ttuwv83.mongodb.net:27017/?ssl=true&replicaSet=atlas-t1z44b-shard-0&authSource=admin&retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", function(){
    console.log(`Connected to port: ${PORT}`)
});
