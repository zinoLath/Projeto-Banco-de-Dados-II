CREATE TABLE bioma (
    id SMALLSERIAL PRIMARY KEY,
    nome_bioma TEXT NOT NULL UNIQUE
);
-- Tabela de Estados
CREATE TABLE estado (
    id SMALLSERIAL PRIMARY KEY, --codigo ibge
    uf CHAR(2) NOT NULL UNIQUE,
    nome_estado TEXT NOT NULL UNIQUE
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
-- Tabela de Relacionamento Bioma-Município
CREATE TABLE bioma_municipio (
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    PRIMARY KEY (municipio_id, bioma_id)
);

-- Tabela de Vegetação
CREATE TABLE caracteristica (
    id SMALLINT PRIMARY KEY,
    nome_caracteristica VARCHAR(100) NOT NULL UNIQUE,
    categoria VARCHAR(13) NOT NULL
);

CREATE TABLE caracteristica_estado (
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, estado_id)
);
CREATE TABLE caracteristica_municipio (
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, municipio_id)
);
CREATE TABLE caracteristica_bioma (
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, bioma_id)
);

-- Tabela de Desmatamento por Estado
CREATE TABLE desmatamento_estado (
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE
);

-- Tabela de Desmatamento por Bioma
CREATE TABLE desmatamento_bioma (
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE
);

-- Tabela de Desmatamento por Município
CREATE TABLE desmatamento_municipio (
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE
);