import Router from "express";
import contentController from "../controllers/content-controller";


const contentRouter = Router();


contentRouter.get('/', contentController.getAll);
contentRouter.get('/:id', contentController.getOne);
contentRouter.post('/', contentController.create);
contentRouter.put('/:id', contentController.update);
contentRouter.delete('/:id', contentController.delete);


export default contentRouter;