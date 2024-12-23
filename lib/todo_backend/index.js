import express from "express";
import dbConnection from "./db/dbConnect.js";
import path from "path"
const app = express();

dbConnection();
app.use('/public', express.static(path.join('public')));

app.use(express.json());
app.listen(3000, (req, res) => {
  console.log("app is listening on port 3000");
});

app.get("/", (req, res) => {
  res.send("hllo ");
});



import todoRouter from "./routes/todoRoutes.js"

app.use("/todo", todoRouter) 
