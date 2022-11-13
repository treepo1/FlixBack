import Router from "express";
import movieController from "../controllers/movie-controller";


const movieRouter = Router();

movieRouter.post('/', movieController.create);

export default movieRouter;