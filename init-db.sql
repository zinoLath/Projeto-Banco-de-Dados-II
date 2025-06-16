CREATE TABLE bioma ( --OK
    id SMALLINT PRIMARY KEY,
    nome_bioma TEXT NOT NULL UNIQUE
);
CREATE TABLE estado ( --OK
    id SMALLINT PRIMARY KEY, --codigo ibge
    uf CHAR(2) NOT NULL UNIQUE,
    nome_estado TEXT NOT NULL UNIQUE
);
CREATE TABLE municipio ( --OK
    id INT PRIMARY KEY,
    nome_municipio TEXT NOT NULL,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE
);

CREATE TABLE bioma_estado ( --OK
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    PRIMARY KEY (bioma_id, estado_id)
);
CREATE TABLE bioma_municipio ( --OK
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    PRIMARY KEY (municipio_id, bioma_id)
);

CREATE TABLE caracteristica ( --OK
    id SMALLINT PRIMARY KEY,
    nome_caracteristica VARCHAR(100) NOT NULL,
    categoria VARCHAR(13) NOT NULL
);
CREATE TABLE caracteristica_estado ( --OK
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, estado_id)
);
CREATE TABLE caracteristica_municipio ( --OK
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    municipio_id INTEGER NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, municipio_id)
);
CREATE TABLE caracteristica_bioma ( --OK
    caracteristica_id SMALLINT NOT NULL REFERENCES caracteristica(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE,
    area NUMERIC(20,2) NOT NULL CHECK (area >= 0),
    PRIMARY KEY (caracteristica_id, bioma_id)
);

CREATE TABLE desmatamento_estado ( --OK
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    estado_id SMALLINT NOT NULL REFERENCES estado(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE
);
CREATE TABLE desmatamento_bioma ( --OK
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE
);
CREATE TABLE desmatamento_municipio ( --OK
    id SERIAL PRIMARY KEY,
    area_desmatada NUMERIC(20,2) NOT NULL CHECK (area_desmatada >= 0),
    ano SMALLINT NOT NULL CHECK (ano BETWEEN 1900 AND 2100),
    municipio_id INT NOT NULL REFERENCES municipio(id) ON DELETE CASCADE,
    bioma_id SMALLINT NOT NULL REFERENCES bioma(id) ON DELETE CASCADE
);