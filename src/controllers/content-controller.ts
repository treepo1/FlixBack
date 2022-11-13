import { Request, Response } from "express";
import prisma from "../../prisma/client";

class ContentController  {

    async getAll(req : Request, res: Response) {

        const conteudos = await prisma.conteudo.findMany();

        res.json(conteudos);

    }

    async getOne(req : Request, res: Response) {

        const { id } = req.params;

        const conteudo = await prisma.conteudo.findUnique({
            where: {
                id: Number(id)
            }
        });

        res.json(conteudo);

    }

    async create(req : Request, res: Response) {

        const { 
            titulo,
            descricao,
            data_lancamento, 
            orcamento,
            linguagem_original,
            status,
            generos } = req.body;

        const conteudo = await prisma.conteudo.create({
            data: {
                titulo,
                descricao,
                data_lancamento, 
                orcamento,
                linguagem_original,
                status,
                conteudo_genero:{
                    connectOrCreate:generos
                }
            }
        });

        res.json(conteudo);

    }

    async update(req : Request, res: Response) {

        const { id } = req.params;
        const { 
            titulo,
            descricao,
            data_lancamento, 
            orcamento,
            linguagem_original,
            status } = req.body;

        const conteudo = await prisma.conteudo.update({
            where: {
                id: Number(id)
            },
            data: {
                titulo,
                descricao,
                data_lancamento, 
                orcamento,
                linguagem_original,
                status
            }
        });

        res.json(conteudo);

    }

    async delete(req : Request, res: Response) {
            
            const { id } = req.params;
    
            const conteudo = await prisma.conteudo.delete({
                where: {
                    id: Number(id)
                }
            });
    
            res.json(conteudo);
    
    }
}

export default new ContentController();