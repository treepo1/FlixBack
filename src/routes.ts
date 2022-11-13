import Router from "express";
import contentController from "./controllers/content-controller";
import contentRouter from "./routes/content-routes";
import generoRouter from "./routes/genero-routes";
import movieRouter from "./routes/movie-routes";



const appRouter = Router();

appRouter.use('/content', contentRouter);
appRouter.use('/genero', generoRouter);
appRouter.use('/filme', movieRouter);

export default appRouter;