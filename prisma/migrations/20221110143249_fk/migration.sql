-- CreateTable
CREATE TABLE `avaliacao` (
    `usuario_id` INTEGER NOT NULL,
    `conteudo_id` INTEGER NOT NULL,
    `nota` DOUBLE NOT NULL,
    `id` VARCHAR(45) NOT NULL,

    INDEX `fk_usuario_has_conteudo_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_usuario_has_conteudo_usuario1_idx`(`usuario_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comentario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `texto` VARCHAR(500) NOT NULL,
    `conteudo_id` INTEGER NOT NULL,
    `usuario_id` INTEGER NOT NULL,
    `resposta` INTEGER NULL,

    INDEX `fk_comentario_comentario1_idx`(`resposta`),
    INDEX `fk_comentario_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_comentario_usuario1_idx`(`usuario_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `conteudo` (
    `titulo` VARCHAR(50) NOT NULL,
    `descricao` VARCHAR(500) NULL,
    `data_lancamento` DATETIME(0) NULL,
    `orcamento` DOUBLE NOT NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `linguagem_original` VARCHAR(45) NOT NULL,
    `status` VARCHAR(45) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `conteudo_genero` (
    `conteudo_id` INTEGER NOT NULL,
    `genero_id` INTEGER NOT NULL,

    INDEX `fk_conteudo_has_genero_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_conteudo_has_genero_genero1_idx`(`genero_id`),
    PRIMARY KEY (`conteudo_id`, `genero_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `diretor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,
    `sobrenome` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dirige` (
    `diretor_id` INTEGER NOT NULL,
    `conteudo_id` INTEGER NOT NULL,

    INDEX `fk_diretor_has_conteudo_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_diretor_has_conteudo_diretor1_idx`(`diretor_id`),
    PRIMARY KEY (`diretor_id`, `conteudo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `emissora` (
    `nome` VARCHAR(45) NOT NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `filme` (
    `conteudo_id` INTEGER NOT NULL,
    `bilheteria` DOUBLE NOT NULL DEFAULT 0,
    `sinopse` VARCHAR(400) NULL,
    `duracao` DOUBLE NOT NULL,

    INDEX `fk_filme_conteudo_idx`(`conteudo_id`),
    PRIMARY KEY (`conteudo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `genero` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `imagem` (
    `url` VARCHAR(100) NOT NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `conteudo_id` INTEGER NOT NULL,
    `fl_poster` BIT(1) NULL,

    INDEX `fk_imagem_conteudo1_idx`(`conteudo_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `serie` (
    `conteudo_id` INTEGER NOT NULL,
    `data_lancamento` DATETIME(0) NULL,
    `audiencia` DOUBLE NULL,

    INDEX `fk_serie_conteudo1_idx`(`conteudo_id`),
    PRIMARY KEY (`conteudo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `temporada` (
    `numero` INTEGER NOT NULL,
    `data_inicio` DATETIME(0) NULL,
    `data_fim` DATETIME(0) NULL,
    `conteudo_id` INTEGER NOT NULL,
    `serie_id` INTEGER NOT NULL,

    INDEX `fk_temporada_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_temporada_serie1_idx`(`serie_id`),
    PRIMARY KEY (`conteudo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transmite` (
    `emissora_id` INTEGER NOT NULL,
    `serie_id` INTEGER NOT NULL,

    INDEX `fk_emissora_has_serie_emissora1_idx`(`emissora_id`),
    INDEX `fk_emissora_has_serie_serie1_idx`(`serie_id`),
    PRIMARY KEY (`emissora_id`, `serie_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(45) NOT NULL,
    `login` VARCHAR(45) NOT NULL,
    `senha` VARCHAR(45) NOT NULL,
    `fl_admin` BIT(1) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `video` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(100) NULL,
    `conteudo_id` INTEGER NOT NULL,
    `fl_trailer` BIT(1) NULL,

    INDEX `fk_video_conteudo1_idx`(`conteudo_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `episodio` (
    `duracao` DOUBLE NULL,
    `audiencia` DOUBLE NULL,
    `conteudo_id` INTEGER NOT NULL,
    `serie_id` INTEGER NOT NULL,
    `temporada_id` INTEGER NOT NULL,

    INDEX `fk_episódio_conteudo1_idx`(`conteudo_id`),
    INDEX `fk_episódio_temporada1`(`serie_id`, `temporada_id`),
    PRIMARY KEY (`conteudo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `avaliacao` ADD CONSTRAINT `fk_usuario_has_conteudo_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `avaliacao` ADD CONSTRAINT `fk_usuario_has_conteudo_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `comentario` ADD CONSTRAINT `fk_comentario_comentario1` FOREIGN KEY (`resposta`) REFERENCES `comentario`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `comentario` ADD CONSTRAINT `fk_comentario_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `comentario` ADD CONSTRAINT `fk_comentario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `conteudo_genero` ADD CONSTRAINT `fk_conteudo_has_genero_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `conteudo_genero` ADD CONSTRAINT `fk_conteudo_has_genero_genero1` FOREIGN KEY (`genero_id`) REFERENCES `genero`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `dirige` ADD CONSTRAINT `fk_diretor_has_conteudo_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `dirige` ADD CONSTRAINT `fk_diretor_has_conteudo_diretor1` FOREIGN KEY (`diretor_id`) REFERENCES `diretor`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `filme` ADD CONSTRAINT `fk_filme_conteudo` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `imagem` ADD CONSTRAINT `fk_imagem_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `serie` ADD CONSTRAINT `fk_serie_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `temporada` ADD CONSTRAINT `fk_temporada_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `temporada` ADD CONSTRAINT `fk_temporada_serie1` FOREIGN KEY (`serie_id`) REFERENCES `serie`(`conteudo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transmite` ADD CONSTRAINT `fk_emissora_has_serie_emissora1` FOREIGN KEY (`emissora_id`) REFERENCES `emissora`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transmite` ADD CONSTRAINT `fk_emissora_has_serie_serie1` FOREIGN KEY (`serie_id`) REFERENCES `serie`(`conteudo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `video` ADD CONSTRAINT `fk_video_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `episodio` ADD CONSTRAINT `fk_episódio_conteudo1` FOREIGN KEY (`conteudo_id`) REFERENCES `conteudo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `episodio` ADD CONSTRAINT `fk_episódio_temporada1` FOREIGN KEY (`temporada_id`) REFERENCES `temporada`(`conteudo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
