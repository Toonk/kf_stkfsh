# README

> clone repository first

### 1st Question

- Humanfriendly answer to 1st question is located in **Solution.pdf** file.
- The **probability.rb** file contains code used for calculations.

### 2nd Question

- The **history.rb** file contains code that calculates the answer for second question.

### Usage

1. After cloning reposotory navigate to project folder

```console
cd kf_stkfsh/
```

2. Build docker-compose, and start container (using **-d** flag runs docker-compose in background)

```console
docker-compose build
docker-compose up -d
```

- Running tests:

```console
docker-compose exec kf_stkfsh ruby tests_runner.rb
```

- Running tests:

```console
docker-compose exec kf_stkfsh ruby tests_runner.rb
```

- Executing question related scripts:

```console
docker-compose exec kf_stkfsh ruby probability.rb
docker-compose exec kf_stkfsh ruby history.rb
```

- All above commands can be run from inside container:

```console
docker-compose exec kf_stkfsh bash
```

- Calculations for **history.rb** are based on **list_of_block_timestamps.txt** file, if the file is removed / renamed script will start generating file from scratch, to force new file generation:

```console
docker-compose exec kf_stkfsh bash
mv list_of_block_timestamps.txt list_of_block_timestamps2.txt
ruby history.rb
```

3. To stop docker-compose, running in background:

```console
docker-compose stop
```
