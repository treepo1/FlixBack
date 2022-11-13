import { Request, Response } from "express";
import prisma from "../../prisma/client";

class GeneroController {
    async getAll(req: Request, res: Response) {
        const generos = await prisma.genero.findMany();
        res.json(generos);
    }

    async getOne(req: Request, res: Response) {
        const { id } = req.params;
        const genero = await prisma.genero.findUnique({
            where: {
                id: Number(id)
            }
        });
        res.json(genero);
    }

    async create(req: Request, res: Response) {
        const { nome } = req.body;
        const genero = await prisma.genero.create({
            data: {
                nome
            }
        });
        res.json(genero);
    }
    async update(req: Request, res: Response) {
        const { id } = req.params;
        const { nome } = req.body;
        const genero = await prisma.genero.update({
            where: {
                id: Number(id)
            },
            data: {
                nome
            }
        });
        res.json(genero);
    }
    async delete(req: Request, res: Response) {
        const { id } = req.params;
        const genero = await prisma.genero.delete({
            where: {
                id: Number(id)
            }
        });
        res.json(genero);
    }
}

export default new GeneroController();