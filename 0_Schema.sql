DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo CHARACTER SET utf8mb4;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);

use isuumo;

ALTER TABLE estate ADD npopularity INTEGER AS (-popularity) STORED NOT NULL;
CREATE INDEX estate_npopularity_id ON estate (npopularity, id);

ALTER TABLE chair ADD npopularity INTEGER AS (-popularity) STORED NOT NULL;
CREATE INDEX chair_npopularity_id ON chair (npopularity, id);

CREATE INDEX chair_price_id ON chair (price, id);
CREATE INDEX chair_stock ON chair (stock);

CREATE INDEX estate_rent_id ON estate (rent, id);

ALTER TABLE estate ADD pt POINT AS (POINT(latitude, longitude)) STORED NOT NULL;
CREATE SPATIAL INDEX estate_pt ON estate (pt);
CREATE INDEX estate_latitude ON estate (latitude);
CREATE INDEX estate_longitude ON estate (longitude);

ALTER TABLE estate ADD rent_x INTEGER AS (CASE WHEN rent < 50000 THEN 0 WHEN rent < 100000 THEN 1 WHEN rent < 150000 THEN 2 ELSE 3 END) STORED NOT NULL;
ALTER TABLE estate ADD door_width_x INTEGER AS (CASE WHEN door_width < 80 THEN 0 WHEN door_width < 110 THEN 1 WHEN door_width < 150 THEN 2 ELSE 3 END) STORED NOT NULL;
ALTER TABLE estate ADD door_height_x INTEGER AS (CASE WHEN door_height < 80 THEN 0 WHEN door_height < 110 THEN 1 WHEN door_height < 150 THEN 2 ELSE 3 END) STORED NOT NULL;
CREATE INDEX estate_rent_x ON estate (rent_x);
CREATE INDEX estate_door_width_x ON estate (door_width_x);
CREATE INDEX estate_door_height_x ON estate (door_height_x);
