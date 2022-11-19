import Router from "express";
import movieController from "../controllers/movie-controller";


const movieRouter = Router();



movieRouter.get('/', movieController.getAll);
movieRouter.get('/:id', movieController.get);
movieRouter.post('/', movieController.create);
movieRouter.delete('/:id', movieController.delete);
movieRouter.put('/:id', movieController.update);


export default movieRouter;