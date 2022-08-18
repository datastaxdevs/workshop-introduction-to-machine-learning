
# Machine Learning with Apache Spark & Cassandra

Welcome to the **Introduction to machine learning** workshop! In this two-hour workshop, we show you how you can leverage the distributed `NoSQL database Apache Cassandra™` to save your datasets, train you models and predict at scale.

Want to learn about the awesomness of distributed databases and computational systems?
Want to get hands-on with DataStax's Cassandra-as-a-Service offering (_for free!_) and use popular Machine Learning tools and algorithms?
Join in and follow along with this workshop!

- Spark + Cassandra = :heart:

- Spark + DataStax Astra = :fire: :rocket: :stars:

It doesn't matter if you join our workshop live or you prefer to do at your own pace, we have you covered. In this repository, you'll find everything you need for this workshop:

## 📋 Table of content

1. [Objectives](#1-objectives)
2. [Frequently asked questions](#2-frequently-asked-questions)
3. [Materials for the Session](#3-materials-for-the-session)
4. [Create your Database](#4-create-your-astra-db-instance)
5. [Algo1](#)
6. [Algo2](#)
7. [Algo3](#)
8. [Algo4](#)
9. [Algo5](#)
10. [Homework](#10-homework)
11. [What's NEXT ](#1-whats-next-)
<p><br/>

> [🔖 Accessing HANDS-ON](#-start-hands-on)

## 1. Objectives

1️⃣ **A™**

2️⃣ **B**

3️⃣ **C**

4️⃣ **D**

🚀 **Have fun with an interactive session**

## 2. Frequently asked questions

<p/>
<details>
<summary><b> 1️⃣ Can I run this workshop on my computer?</b></summary>
<hr>
<p>There is nothing preventing you from running the workshop on your own machine. If you do so, you will need the following:
<ol>
<li><b>git</b> installed on your local system
</ol>
</p>
In this readme, we try to provide instructions for local development as well - but keep in mind that the main focus is development on Gitpod, hence <strong>we can't guarantee live support</strong> about local development in order to keep on track with the schedule. However, we will do our best to give you the info you need to succeed.
</details>
<p/>
<details>
<summary><b> 2️⃣ What other prerequisites are required?</b></summary>
<hr>
<ul>
<li>You will need enough *real estate* on screen, we will ask you to open a few windows and it would not fit on mobiles (tablets should be OK)
<li>You will need an Astra account: don't worry, we'll work through that in the following
<li>As "Intermediate level" we expect you to know what java and Spring are. 
</ul>
</p>
</details>
<p/>
<details>
<summary><b> 3️⃣ Do I need to pay for anything for this workshop?</b></summary>
<hr>
<b>No.</b> All tools and services we provide here are FREE. FREE not only during the session but also after.
</details>
<p/>
<details>
<summary><b> 4️⃣ Will I get a certificate if I attend this workshop?</b></summary>
<hr>
Attending the session is not enough. You need to complete the homework detailed below and you will get a nice badge that you can share on linkedin or anywhere else *(open badge specification)*
</details>
<p/>

## 3. Materials for the Session

It doesn't matter if you join our workshop live or you prefer to work at your own pace,
we have you covered. In this repository, you'll find everything you need for this workshop:

- [Slide deck](/slides/slides.pdf)
- [Discord chat](https://dtsx.io/discord)
- [Questions and Answers](https://community.datastax.com/)

----

# 🏁 Start Hands-on

## 4. Create your Astra DB instance

_**`ASTRA DB`** is the simplest way to run Cassandra with zero operations at all - just push the button and get your cluster. No credit card required, 40M read/write operations and about 80GB storage monthly for free - sufficient to run small production workloads. If you end your credits the databases will pause, no charge_

Leveraging [Database creation guide](https://awesome-astra.github.io/docs/pages/astra/create-instance/#c-procedure) create a database. *Right-Click the button* with *Open in a new TAB.*

<a href="https://astra.dev/2-16"><img src="images/create_astra_db_button.png?raw=true" /></a>

|Field|Value|
|---|---|
|**Database Name**| `workshops`|
|**Keyspace Name**| `machine_learning`|
|**Regions**| Select `GOOGLE CLOUD`, then an Area close to you, then a region with no LOCKER 🔒 icons, those are the region you can use for free.   |

> **ℹ️ Note:** If you already have a database `workshops`, simply add a keyspace `machine_learning` using the `Add Keyspace` button on the bottom right hand corner of db dashboard page.

While the database is being created, you will also get a **Security token**:
save it somewhere safe, as it will be needed to later in others workshop (In particular the string starting with `AstraCS:...`.)

The status will change from `Pending` to `Active` when the database is ready, this will only take 2-3 minutes. You will also receive an email when it is ready.

[🏠 Back to Table of Contents](#-table-of-content)


## 5. Algo1

TBD

## Requirements

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [DataStax Astra Registration](http://astra.datastax.com) (_sign up with the email you used to register for the workshop!_)
* [Docker](https://www.docker.com/products/docker-desktop)
* [Docker-compose](https://docs.docker.com/compose/install/) (_included with Docker Desktop for Mac and Windows installs_)

## Installation

```
git clone https://github.com/riptano/machine-learning-workshop-astra-online.git
cd machine-learning-workshop-astra-online
docker-compose up -d
```

## Setup

- Download the [Secure Connect Bundle](https://docs.datastax.com/en/astra/aws/doc/dscloud/astra/dscloudObtainingCredentials.html) for your Astra Database
- Move the Secure Connect Bundle to [./jupyter/secureconnect](./jupyter/secureconnect)  
- For the Spark labs, access Jupyter Notebooks: http://localhost:8888 password: `datastax`

You may need to use some custom IP instead of `localhost` if you use docker-for-mac, docker-for-windows or similar installation.

## Known Issues

In some cases executing the exercises may lead to memory issues, especially on weaker or non-Linux machines due to docker limitations on memory. If you have any issues with exercises after the first few, try to clean up and start again `docker-compose kill && docker-compose down && docker-compose up -d`. You may need to repeat steps of the notebook you were working on.
