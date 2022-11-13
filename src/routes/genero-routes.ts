import Router from "express";
import generoController from "../controllers/genero-controller";


const generoRouter = Router();


generoRouter.get('/', generoController.getAll);
generoRouter.get('/:id', generoController.getOne);
generoRouter.post('/', generoController.create);
generoRouter.put('/:id', generoController.update);
generoRouter.delete('/:id', generoController.delete);


export default generoRouter;