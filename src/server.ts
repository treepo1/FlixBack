import express from "express";
import prisma from "../prisma/client";
import contentController from "./controllers/content-controller";
import appRouter from "./routes";
import cors from "cors";
import morgan from "morgan";

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(morgan('dev'));
app.use(appRouter);


app.listen(3333, () => {
    console.log("Server is running on port 3333");
});

