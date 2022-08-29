
CREATE TABLE IF NOT EXISTS socialmedia (
  status_id         INT,
  social_type       TEXT,
  num_reactions     INT,
  num_comments      INT,
  num_shares        INT,
  num_likes         INT,
  num_loves         INT,
  num_wows          INT,
  num_hahas         INT,
  num_sads          INT,
  num_angrys        INT,
  PRIMARY KEY (status_id)
);

CREATE TABLE IF NOT EXISTS wines (
    wineid          INT,
    fixedacidity    FLOAT,
    volatileacidity FLOAT,
    citricacid      FLOAT,
    sugar           FLOAT,
    chlorides       FLOAT,
    freesulfur      FLOAT,
    totalsulfur     FLOAT,
    density         FLOAT,
    ph              FLOAT,
    sulphates       FLOAT,
    alcohol         FLOAT,
    quality         FLOAT,
    PRIMARY KEY (wineid)
);

CREATE TABLE IF NOT EXISTS movies (
    movieid         INT,
    title           TEXT,
    genres          TEXT,
    PRIMARY KEY (movieid)
);

CREATE TABLE IF NOT EXISTS movieratings (
    userid          INT,
    movieid         INT,
    rating          FLOAT,
    timestamp       TEXT,
    PRIMARY KEY (userid, movieid)
);

CREATE TABLE IF NOT EXISTS jokes (
    userid          INT,
    jokeid          INT,
    rating          FLOAT,
    PRIMARY KEY (userid, jokeid)
);
