
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
5. [Setup](#5-setup)
6. [Algorithms](#6-algorithms)
7. [Homework](#7-homework)
8. [What's NEXT](#8-whats-next)

> [🔖 Accessing HANDS-ON](#-start-hands-on)

## 1. Objectives

1️⃣ **Learn about the NoSQL database Apache Cassandra™**

2️⃣ **Meet Apache Spark™ and its superpowers**

3️⃣ **Learn about the main ideas and practice of Machine Learning (ML)**

4️⃣ **Get a practical understanding of some of the main ML algorithms**

🚀 **Have fun with an interactive session (Python interactive notebooks + Cassandra + Spark)**

## 2. Frequently asked questions

<details>
<summary>**1️⃣ Can I run this workshop on my computer?**</summary>

There is nothing preventing you from running the workshop on your own machine. If you do so, you will need: `git`, `docker`, `docker-compose`.

In this readme, we try to provide instructions for local development as well - but keep in mind that the main focus is development on Gitpod, hence **we can't guarantee live support** about local development in order to keep on track with the schedule. However, we will do our best to give you the info you need to succeed.

</details>

<details>
<summary>**2️⃣ Are there other prerequisites?**</summary>

You will need enough *real estate* on screen, we will ask you to open a few windows and it would not fit on mobiles (tablets should be OK).

You will need an Astra account: don't worry, we'll work through that in the following.

</details>

<details>
<summary>**3️⃣ Do I need to pay for anything for this workshop?**</summary>

**No.** All tools and services we provide here are FREE. FREE not only during the session but also afterwards.

</details>

<details>
<summary>**4️⃣ Will I get a certificate if I attend this workshop?**</summary>

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

_**`ASTRA DB`** is the simplest way to run Cassandra with zero operations at all - just push the button and get your cluster. No credit card required, 40M read/write operations and about 80GB storage monthly for free - sufficient to run small production workloads. If you end your credits the databases will pause, no charge_

Leveraging [Database creation guide](https://awesome-astra.github.io/docs/pages/astra/create-instance/#c-procedure) create a database. *Right-Click the following button* and *Open in a new TAB.*

<a href="https://astra.dev/8-31" target="_blank" rel="noopener"><img src="images/create_astra_db_button.png?raw=true" /></a>

|Field|Value|
|---|---|
|**Database Name**| `workshops`|
|**Keyspace Name**| `machine_learning`|
|**Regions**| Select `GOOGLE CLOUD`, then an Area close to you, then a region with no LOCKER 🔒 icons, those are the region you can use for free.   |

> **ℹ️ Note:** If you already have a database `workshops`, simply add a keyspace `machine_learning` using the `Add Keyspace` button on the bottom right hand corner of db dashboard page.

While the database is being created, you will also get a
[**Security token**](https://awesome-astra.github.io/docs/pages/astra/create-token/#b-prerequisites):
save it somewhere safe, since we'll need it later during setup.

The database status will change from `Pending` to `Active` when the database is ready, this will only take 2-3 minutes. You will also receive an email when it is ready.

> If you already had the database, you can still create a new token: see [here](https://awesome-astra.github.io/docs/pages/astra/create-token/#b-prerequisites).

Then go to the Connect tab for your database and download your **Secure Connect Bundle**, as described [at this link](https://awesome-astra.github.io/docs/pages/astra/download-scb/). It's a ZIP file of about 12Kb, which you will need later.

[🏠 Back to Table of Contents](#-table-of-content)

## 5. Setup

We suggest to use Gitpod: **right-click** on the following button and **open in new tab**:

<a href="https://gitpod.io/#https://github.com/datastaxdevs/workshop-introduction-to-machine-learning"><img src="images/open_in_gitpod.svg?raw=true" /></a>

> You can also run everything locally. In this case, you may need to know what you are doing, as we won't be able to troubleshoot live.

If you are on Gitpod, simply follow the on-screen instructions to get everything running:

- Wait 2-3 minutes as your IDE (and Linux box) gets provisioned...
- Enter the following information to connect to DB:
  + Astra DB Token ID
  + Astra DB Token Secret
  + Keyspace name (`machine_learning` by default)
- When asked, drag-and-drop (or copy) the Secure bundle to the required destination
- Eventually the Gitpod console will spawn a new tab with the Jupter UI running (check your pop-up blocker to let it through)
- Insert the password `mlrules` to access the Jupyter UI

<details><summary>Steps for running locally (click to show)</summary>

- Clone the repo, `cd` into it and launch `./init_tools.sh` (to get the required tools ready and `docker-compose` up and running).
- Once that is finished, launch `./setup.sh` and follow the instructions.

> You may need to use some custom IP instead of `localhost` if you
> use docker-for-mac, docker-for-windows or similar installation.

> _Known Issue_: in some cases executing the exercises may lead to memory issues, especially
> on weaker or non-Linux machines due to docker limitations on memory. If you have any
> issues with exercises after the first few, try to clean up and start again
> `docker-compose kill && docker-compose down && docker-compose up -d`.
> You may need to repeat steps of the notebook you were working on.

</details>

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
