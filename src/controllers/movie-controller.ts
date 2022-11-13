import { Request, Response } from "express";
import prisma from "../../prisma/client";

class MovieController {
    async create(req: Request, res: Response) { 
        
        const { 
            titulo,
            imagens,
            descricao,
            data_lancamento, 
            orcamento,
            linguagem_original,
            status,
            bilheteria,
            sinopse,
            duracao,
            generos } = req.body;

        const newMovie = await prisma.conteudo.create({
            data:{
                titulo,
                descricao,
                data_lancamento, 
                orcamento,
                linguagem_original,
                status,
                filme:{
                    create:{
                        duracao,
                        sinopse,
                        bilheteria 
                    }
                }
                }
            })

            await prisma.conteudo_genero.createMany({
                data:generos.map((genero:any) => (
                    {genero_id: genero.id,
                    conteudo_id: newMovie.id}
                ))
            })

            if(imagens) {
                await prisma.imagem.createMany({
                    data: imagens.map((imagem: any) => (
                        {url: imagem.url,
                        fl_poster: imagem.fl_poster,
                        conteudo_id: newMovie.id}
                    ))
                })
            }




        res.json(newMovie)
    }
}

export default new MovieController();