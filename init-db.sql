-- Tabela de Biomas
CREATE TABLE bioma (
    id SMALLSERIAL PRIMARY KEY,
    nome_bioma TEXT NOT NULL UNIQUE
);

-- Tabela de Estados
CREATE TABLE estado (
    id SMALLSERIAL PRIMARY KEY,
    uf CHAR(2) NOT NULL UNIQUE,
    nome_estado TEXT NOT NULL UNIQUE
);

-- Tabela de Áreas de Conservação
CREATE TABLE area_conservacao (
    id SERIAL PRIMARY KEY,
    nome_uc TEXT NOT NULL UNIQUE
);

-- Tabela de Municípios
CREATE TABLE municipio (
    id SERIAL PRIMARY KEY,
    nome_municipio TEXT NOT NULL,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    UNIQUE (estado_id)
);

-- Tabelas de Relacionamento Bioma-Estado
CREATE TABLE bioma_estado (
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    PRIMARY KEY (bioma_id, estado_id)
);

-- Tabela de Relacionamento Bioma-Área de Conservação
CREATE TABLE bioma_area_conservacao (
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    ac_id INTEGER NOT NULL REFERENCES area_conservacao(id) ON DELETE CASCADE,
    PRIMARY KEY (bioma_id, ac_id)
);

-- Tabela de Relacionamento Bioma-Município
CREATE TABLE bioma_municipio (
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    PRIMARY KEY (municipio_id, bioma_id)
);

-- Tabela de Vegetação
CREATE TABLE vegetacao (
    id SMALLSERIAL PRIMARY KEY,
    vegetacao_nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabelas de Relacionamento Vegetação-Bioma
CREATE TABLE vegetacao_bioma (
    vegetacao_id SMALLINT NOT NULL REFERENCES vegetacao(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (vegetacao_id, bioma_id)
);

-- Tabelas de Relacionamento Vegetação-Estado
CREATE TABLE vegetacao_estado (
    vegetacao_id SMALLINT NOT NULL REFERENCES vegetacao(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (vegetacao_id, estado_id)
);

-- Tabela de Geologia
CREATE TABLE geologia (
    id SMALLSERIAL PRIMARY KEY,
    provincias_nome TEXT NOT NULL UNIQUE
);

-- Tabelas de Relacionamento Geologia-Bioma
CREATE TABLE geologia_bioma (
    geologia_id SMALLINT NOT NULL REFERENCES geologia(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (geologia_id, bioma_id)
);

-- Tabelas de Relacionamento Geologia-Estado
CREATE TABLE geologia_estado (
    geologia_id SMALLINT NOT NULL REFERENCES geologia(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (geologia_id, estado_id)
);

-- Tabela de Geomorfologia
CREATE TABLE geomorfologia (
    id SMALLSERIAL PRIMARY KEY,
    dominio_nome TEXT NOT NULL UNIQUE
);

-- Tabelas de Relacionamento Geomorfologia-Bioma
CREATE TABLE geomorfologia_bioma (
    geomorfologia_id SMALLINT NOT NULL REFERENCES geomorfologia(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (geomorfologia_id, bioma_id)
);

-- Tabelas de Relacionamento Geomorfologia-Estado
CREATE TABLE geomorfologia_estado (
    geomorfologia_id SMALLINT NOT NULL REFERENCES geomorfologia(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (geomorfologia_id, estado_id)
);

-- Tabela de Pedologia
CREATE TABLE pedologia (
    id SMALLSERIAL PRIMARY KEY,
    ordem_nome TEXT NOT NULL UNIQUE
);

-- Tabelas de Relacionamento Pedologia-Bioma
CREATE TABLE pedologia_bioma (
    pedologia_id SMALLINT NOT NULL REFERENCES pedologia(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (pedologia_id, bioma_id)
);

-- Tabelas de Relacionamento Pedologia-Estado
CREATE TABLE pedologia_estado (
    pedologia_id SMALLINT NOT NULL REFERENCES pedologia(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (pedologia_id, estado_id)
);

-- Tabela de Desmatamento
CREATE TABLE desmatamento (
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE
);

-- Tabela de Queimadas
CREATE TABLE queimadas (
    id SERIAL PRIMARY KEY,
    numero_focos INTEGER NOT NULL CHECK (numero_focos >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE
);