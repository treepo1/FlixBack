import { Request, Response } from "express";
import prisma from "../../prisma/client";   

class MovieController {
    async create(req: Request, res: Response) { 
        
        const { 
            titulo,
            imagens,
            videos,
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

            if(videos){
                await prisma.video.createMany({
                    data: videos.map((video: any) => (
                        {url: video.url,
                        fl_trailer: video.fl_trailer,
                        conteudo_id: newMovie.id}
                    ))
                })
            }




        res.json(newMovie)
    }

    async get(req: Request, res: Response) {
        const { id } = req.params;
        
        const movie = await prisma.conteudo.findUnique({
            where: { id: Number(id) },
            include: {
                filme: true,
                conteudo_genero: {
                    include: {
                    genero: true
                }},
                imagem: true,
                video: true
            }
        })

        res.json(movie);
    }

    async getAll(req: Request, res: Response) {
        const movies = await prisma.conteudo.findMany({
            include: {
                filme: true,
                conteudo_genero: {
                    include: {
                    genero: true
                }},
                imagem: true,
                video: true,
            },
        })

        res.json(movies);
    }

    async update(req: Request, res: Response) {
                
    
        const { id } = req.params;

        const { 
            titulo,
            imagens,
            videos,
            descricao,
            data_lancamento, 
            orcamento,
            linguagem_original,
            status,
            bilheteria,
            sinopse,
            duracao,
            generos } = req.body;

        const updatedMovie = await prisma.conteudo.update({
            where:{id: Number(id)},
            data:{
                titulo,
                descricao,
                data_lancamento, 
                orcamento,
                linguagem_original,
                status,
                filme:{
                    update:{
                        duracao,
                        sinopse,
                        bilheteria 
                    }
                }
                }
            })

            await prisma.conteudo_genero.deleteMany({
                where:{
                    conteudo_id: Number(id)
                }
            })


            generos.map( async (genero:any) => (
                await prisma.conteudo_genero.upsert({
                    where: {
                        conteudo_id_genero_id: {
                            conteudo_id: Number(id),
                            genero_id: genero.id
                        }
                    },
                    update: {
                        conteudo_id: Number(id),
                        genero_id: genero.id
                    },
                    create: {
                        conteudo_id: Number(id),
                        genero_id: genero.id
                    }
                })
            ))


            if(imagens) {
                imagens.forEach(async (imagem: any) => {
                    if(imagem.id) {
                        await prisma.imagem.update({
                            where:{id: Number(imagem.id)},
                            data:{
                                url: imagem.url,
                                fl_poster: imagem.fl_poster,
                                conteudo_id: updatedMovie.id
                            }
                        })
                    } else {
                        await prisma.imagem.create({
                            data:{
                                url: imagem.url,
                                fl_poster: imagem.fl_poster,
                                conteudo_id: updatedMovie.id
                            }
                        })
                    }
                })
            }

            if(videos) {
                videos.forEach(async (video: any) => {
                    if(video.id) {
                        await prisma.video.update({
                            where:{id: Number(video.id)},
                            data:{
                                url: video.url,
                                fl_trailer: video.fl_trailer,
                                conteudo_id: updatedMovie.id
                            }
                        })
                    } else {
                        await prisma.video.create({
                            data:{
                                url: video.url,
                                fl_trailer: video.fl_trailer,
                                conteudo_id: updatedMovie.id
                            }
                        })
                    }
                })
            }




        res.json(updatedMovie)
    }

    async delete(req: Request, res: Response) {
        const { id } = req.params;
    

    const filmeExists = await prisma.conteudo.findFirst({
        where: { id: Number(id) },
    })



    if(!filmeExists) {
        return res.status(404).json({message: "Filme não encontrado"})
    }


    await prisma.$transaction([

        prisma.filme.delete({
            where: { conteudo_id: Number(id) },
        }),
    
        prisma.conteudo_genero.deleteMany({
                where:{
                    conteudo_id: parseInt(id)
                },
    
            }),
    
        prisma.imagem.deleteMany({
                where:{
                    conteudo_id: parseInt(id)
                }
            }),
    
        prisma.video.deleteMany({
                where:{ 
                    conteudo_id: parseInt(id)
                }
            }),
    
        prisma.conteudo.delete({
                where: { id: parseInt(id) },
        })
    ])



        res.json({msg:"Filme deletado com sucesso"})
    }

}

export default new MovieController();   