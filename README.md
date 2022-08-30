
# Machine Learning with Apache Spark & Cassandra

Welcome to the **Introduction to machine learning** workshop! In this two-hour workshop, we show you how you can leverage the distributed `NoSQL database Apache Cassandra™` to save your datasets, train you models and predict at scale.

Want to learn about the awesomeness of distributed databases and computational systems?
Want to get hands-on with DataStax's Cassandra-as-a-Service offering (_for free!_) and use popular Machine Learning tools and algorithms?
Join in and follow along with this workshop!

- Spark + Cassandra = :heart:

- Spark + DataStax Astra DB = :fire: :rocket: :stars:

It doesn't matter if you join our workshop live or you prefer to do at your own pace, we have you covered. In this repository, you'll find everything you need for this workshop:

## 📋 Table of contents

1. [Objectives](#1-objectives)
2. [Frequently asked questions](#2-frequently-asked-questions)
3. [Materials for the Session](#3-materials-for-the-session)
4. [Create your Database](#4-create-your-astra-db-instance)
5. [Setup your Database](#5-setup-your-astra-db-instance)
6. [Setup Jupyter Notebook](#6-setup-jupyter-notebook)
7. [Algorithms](#6-algorithms)
8. [Homework](#7-homework)
9. [What's NEXT](#8-whats-next)

> [🔖 Accessing HANDS-ON](#-start-hands-on)

## 1. Objectives

1️⃣ **Learn about the NoSQL database Apache Cassandra™**

2️⃣ **Meet Apache Spark™ and its superpowers**

3️⃣ **Learn about the main ideas and practice of Machine Learning (ML)**

4️⃣ **Get a practical understanding of some of the main ML algorithms**

🚀 **Have fun with an interactive session (Python interactive notebooks + Cassandra + Spark)**

## 2. Frequently asked questions

<details>
<summary><b>1️⃣ Can I run this workshop on my computer?</b></summary>

There is nothing preventing you from running the workshop on your own machine. If you do so, you will need: `git`, `docker`, `docker-compose`.

In this readme, we try to provide instructions for local development as well - but keep in mind that the main focus is development on Gitpod, hence **we can't guarantee live support** about local development in order to keep on track with the schedule. However, we will do our best to give you the info you need to succeed.

</details>

<details>
<summary><b>2️⃣ Are there other prerequisites?</b></summary>

You will need enough *real estate* on screen, we will ask you to open a few windows and it would not fit on mobiles (tablets should be OK).

You will need an Astra account: don't worry, we'll work through that in the following.

</details>

<details>
<summary><b>3️⃣ Do I need to pay for anything for this workshop?</b></summary>

**No.** All tools and services we provide here are FREE. FREE not only during the session but also afterwards.

</details>

<details>
<summary><b>4️⃣ Will I get a certificate if I attend this workshop?</b></summary>

Attending the session is not enough. You need to complete the [homework detailed below](#7-homework)
and you will get a nice badge that you can share on linkedin or anywhere else
_(the badge conforms to the "open badge" specifications)_.

</details>

## 3. Materials for the Session

It doesn't matter if you join our workshop live or you prefer to work at your own pace,
we have you covered. In this repository, you'll find everything you need for this workshop:

- [Slide deck](/slides/slides.pdf)
- [Discord chat](https://dtsx.io/discord)
- [Ask on StackOverflow](https://stackoverflow.com/questions/ask?tags=cassandra) (or [StackExchange](https://dba.stackexchange.com/questions/ask?tags=cassandra) for operators)

### Requirements

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [DataStax Astra Registration](http://astra.datastax.com) (_sign up with the email you used to register for the workshop!_)
* [Docker](https://www.docker.com/products/docker-desktop)
* [Docker-compose](https://docs.docker.com/compose/install/) (_included with Docker Desktop for Mac and Windows installs_)

----

# 🏁 Start Hands-on

## 4. Create your Astra DB instance

#### ✅ 4a. Sign in (or sign up) to your Astra account

<a href="https://astra.dev/yt-8-31"><img src="images/create_astra_db_button.png?raw=true" /></a>

#### ✅ 4b. Create an application token by following <a href="https://awesome-astra.github.io/docs/pages/astra/create-token/" target="_blank">these instructions</a>. Skip this step is you already have a token. You can reuse the same token in our other workshops, too.

> Your token should look like: `AstraCS:....`

#### ✅ 4c. Start Gitpod

We suggest to use `#Gitpod` but you can also run everything locally.

[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://github.com/datastaxdevs/workshop-introduction-to-machine-learning/tree/cedrick-cli) (right-click -> open in new TAB)

<details><summary>Steps for running locally (click to show)</summary>

- Clone the repo

```
git clone https://github.com/datastaxdevs/workshop-introduction-to-machine-learning.git
cd workshop-introduction-to-machine-learning
```

- Install Astra CLI 
```
curl -Ls "https://dtsx.io/get-astra-cli"
```

- Close the terminal and open a new one in the folder.
</details>

.

#### ✅ 4d. Setup Astra CLI by providing your application token

```
astra setup
```

#### ✅ 4e.List your existing Astra DB databases:

```
astra db list
```

#### ✅ 4f. Create database `workshops` and keyspace `machine_learning` if they do not exist:

```
astra db create workshops -k machine_learning --if-not-exist
```

#### ✅ 4g) Check the status of database `workshops`:
```
 astra db get workshops | grep Status | cut -b 28-45
```

#### ✅ 4h) If database `workshops` exists and has status `HIBERNATED`, resume the database. 

```
astra db resume workshops
```

#### ✅ 4i) If database `workshops` has status `RESUMING` or `PENDING`, **wait until the status becomes `ACTIVE`**:
```
astra db get workshops
```

## 5. Setup your Astra DB instance

#### ✅ 5a) Start the CQL shell and connect to database `workshops` and keyspace `machine_learning`:

```
clear
astra db cqlsh workshops -k machine_learning
```

#### ✅ 5b) Initialize the Schema with `cqlsh`

```sql
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

describe tables;

quit;
```

You can also create the table by running a CQL script
```
astra db cqlsh workshops -k machine_learning -f ./initialize/create_tables.cql
```

#### ✅ 5c) Populate table `socialmedia`

```
astra db dsbulk workshops \
  load \
  -url jupyter/data/socialMedia.csv \
  -c csv \
  -delim ',' \
  -m "status_id,social_type,num_reactions,num_comments,num_shares,num_likes,num_loves,num_wows,num_hahas,num_sads,num_angrys" \
  -header false \
  -k "machine_learning" \
  -t socialmedia
```

> 🖥️ Output
>
> ```
> total | failed | rows/s |    p50ms |    p99ms |    p999ms | batches
> 6,622 |      0 |    139 | 1,131.25 | 4,294.97 | 13,555.99 |    1.00
> ```

#### ✅ 5d) Populate table `wines`

```
astra db dsbulk workshops \
  load \
  -url jupyter/data/winequality.csv \
  -c csv \
  -delim ',' \
  -m "wineid,fixedacidity,volatileacidity,citricacid,sugar,chlorides,freesulfur,totalsulfur,density,ph,sulphates,alcohol,quality" \
  -header false \
  -k "machine_learning" \
  -t wines
```

> 🖥️ Output
>
> ```
> total | failed | rows/s |    p50ms |    p99ms |   p999ms | batches
> 6,497 |      0 |    166 | 1,131.18 | 3,892.31 | 6,442.45 |    1.00
> ```


#### ✅ 5e) Populate table `movieratings`

```
astra db dsbulk workshops \
  load \
  -url jupyter/data/ratings.csv \
  -c csv \
  -delim ',' \
  -m "userid,movieid,rating,timestamp" \
  -header false \
  -k "machine_learning" \
  -t movieratings
```

#### ✅ 5f) Populate table `movies`

```
astra db dsbulk workshops \
  load \
  -url jupyter/data/movies.csv \
  -c csv \
  -delim ',' \
  -m "movieid,title,genres" \
  -header false \
  -k "machine_learning" \
  -t movies
```

total | failed | rows/s |  p50ms |    p99ms |    p999ms | batches
27,278 |      0 |    272 | 660.79 | 4,731.17 | 11,811.16 |    1.00


#### ✅ 5g) Populate table `jokes`

```
astra db dsbulk workshops \
  load \
  -url jupyter/data/jester_ratings3.csv \
  -c csv \
  -delim ',' \
  -m "userid,jokeid,rating" \
  -header false \
  -k "machine_learning" \
  -t jokes
```

## 6. Setup Jupyter notebook

Jupyter notebook is a web based application that we will use to demonstrate the different algorithms

#### ✅ 6a) Download credentials as a `zip` for jupyter

```
astra db workshops download-scb -f ./jupyter/secureconnect/secure-connect-workshops.zip
```

> You might get an error if your database contains multiple regions (not on the free tier). If so please, use the following command instead
> ```
> astra db workshops download-scb -d ./jupyter/secureconnect/
> ```
> And then rename the file you want to use case `secure-connect-workshops.zip`

#### ✅ 6b. Init environment variables

```
export ASTRA_DB_CLIENT_ID=token
export ASTRA_DB_CLIENT_SECRET=`astra config get default --key ASTRA_DB_APPLICATION_TOKEN`
export ASTRA_DB_SECURE_BUNDLE_PATH="./secureconnect/secure-connect-workshops.zip"
export ASTRA_DB_KEYSPACE="machine_learning"
```

#### ✅ Step 6c. Start Jupyter with Docker

```
docker-compose up -d
```

> 🖥️ Output
>
> ```
>  [+] Running 1/1
>  ⠿ Container workshop-introduction-to-machine-learning-jupyter-1  Started 0.3s
> ```

**✅ Step 6d.** Signin to Jupyter

- run the following 

```bash
JUPYTER_URL="$(gp url 8888 2>/dev/null)"
if [ -n "${JUPYTER_URL}" ]; then
  echo -e "\n\t\t** OPENING JUPYTER IN NEW TAB. PLEASE CHECK YOUR POP-UP BLOCKER **\n";
  echo -e "\t\t** TARGET URL: ${JUPYTER_URL} **";
  gp preview --external ${JUPYTER_URL};
else
  JUPYTER_URL="http://localhost:8888/"
  echo -e "\n\t\t** PLEASE POINT YOUR BROWSER TO ${JUPYTER_URL} **\n";
fi
```

- Eventually the Gitpod console will spawn a new tab with the Jupter UI running (check your pop-up blocker to let it through)

- Insert the password `mlrules` to access the Jupyter UI

<details><summary>Advices if running locally (click to show)</summary>

> You may need to use some custom IP instead of `localhost` if you
> use docker-for-mac, docker-for-windows or similar installation.

> _Known Issue_: in some cases executing the exercises may lead to memory issues, especially
> on weaker or non-Linux machines due to docker limitations on memory. If you have any
> issues with exercises after the first few, try to clean up and start again
> `docker-compose kill && docker-compose down && docker-compose up -d`.
> You may need to repeat steps of the notebook you were working on.

</details>
.

## 6. Algorithms

The main Jupyter web interface will list five numbered notebooks available.
Each one illustrates a key algorithm in Machine Learning:

- **K-Means** Clustering
- **Naive Bayes** inference
- **Random Forest** classification
- **FP-Growth** recommendation
- **Collaborative Filtering** recommendation

Click a notebook to open it in a new tab, then you can run all code cells
sequentially by clicking on them and hitting `Ctrl + Enter`.
Watch each code cell execute (its numbering will display `[*]` while running)
and, when it finishes, move on to the next.

> _Note_: if you see errors such as empty or nonexisting tables, chances are
> you started the lab while the database was still being created or was in
> "maintenance mode". To fix this, simply issue the command `./initialize/initialize.sh`
> and wait one minute or so for it to complete.

## 7. Homework

_(coming soon)_

## 8. What's NEXT

We've just scratched the surface of what you can do with
- Astra DB, built on Apache Cassandra™;
- Apache Spark™
- the awesome algorithm in the Machine Learning field.

Go take a look at [DataStax for Developers](https://www.datastax.com/dev) to see what else is possible.
There's plenty to dig into!

<img src="images/intro-ml-badge.png?raw=true" width="150" align="right" />

**Congratulations: you made to the end of today's workshop.**

Don't forget to [submit your homework](#7-homework) and be awarded a nice verified badge!

**... and see you at our next workshop!**

> Sincerely yours, The DataStax Developers
