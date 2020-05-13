# Desafio - Movimentação de Contas
O sistema consiste em uma aplicação em linha de comando, que realiza o balanço de contas baseados em arquivos csv.

## Como executar

### Requesitos do sistema
- Ruby ([ruby](https://www.ruby-lang.org/pt/downloads/ "ruby"))
- Docker/Docker-compose ([docker](https://docs.docker.com/engine/install "docker") / [docker-compose](https://docs.docker.com/compose/install/ "docker-compose"))
- MySQL ([mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/ "mysql"))

### Utilizando Docker e atribuindo banco de dados

Dentro da pasta do projeto, acesse o terminal e execute os seguintes comandos a seguir:

construa a imagem dos containers
```
$ docker-compose build
```

Execute os containers em background liberando acesso ao terminal
```
$ docker-compose up -d
```
Acesse o terminal ativo do container **"account_movement_challenge"**
```
$ docker exec -it account_movement_challenge bash
```
Crie o banco de dados e execute as migrações
```
$ rails db:create db:migrate
```

## Rodando testes
Ainda dentro do terminal do container, é possível executar os testes e garantir o funcionamento da aplicação
```
$ bundle exec rspec
```

## Funcionalidades
O sistema consiste em poder realizar a importação via linha de comando. Desta forma, foi implementado o uso de tasks utilizando Ruby on Rails.

**OBS**: Os arquivos para importação mencionados se encontram dentro da pasta 'db' do projeto

### Importação em conjunto e exibição de saldo final
Executa a importação de contas e transações e em sequência exibe o saldo das contas atualizado

#### Executando comando de importação
```
$ rails "csv_import:files[accounts.csv, transactions.csv]"
```

#### Saída esperada
```
Importando contas de accounts.csv para base de dados...

Importação finalizada.

-------------------------------

Importando transações de 'transactions.csv' para base de dados...

Importação finalizada.

-------------------------------

- Saldo atual da conta 12345: R$ 960

- Saldo atual da conta 54321: R$ 5325

- Saldo atual da conta 67891: R$ 350

- Saldo atual da conta 19876: R$ 1375
```

### Importação de contas
Executa a importação apenas de contas

#### Executando comando de importação
```
$ rails "account_csv_:import[accounts.csv]"
```

**Saída esperada**
```
Importando contas de accounts.csv para base de dados...

Importação finalizada.
```

**Saída excepcional**
```
Importando contas de accounts.csv para base de dados...

Conta 12345 já encontra-se em nossa base de dados

Conta 54321 já encontra-se em nossa base de dados

Conta 67891 já encontra-se em nossa base de dados

Conta 19876 já encontra-se em nossa base de dados

Importação finalizada.
```

### Importação de transações
Executa a importação de contas

#### Executando comando de importação
```
$ rails "transaction_csv_:import[transactions.csv]"
```

**Saída esperada**
```
Importando contas de accounts.csv para base de dados...

Importação finalizada.
```

### Exibição de saldos
Exibe o saldo das contas já importadas

#### Executando comando
```
$ rails account_csv:show_all_amounts
```

**Saída esperada**
```
- Saldo atual da conta 12345: R$ 960

- Saldo atual da conta 54321: R$ 5325

- Saldo atual da conta 67891: R$ 350

- Saldo atual da conta 19876: R$ 1375
```

## Progresso do projeto

- [x] Setup do Docker
- [x] Setup do banco
- [x] Criação de Model e Migrations
- [x] Criação de endpoints
- [x] Criação de tasks
- [x] Testes unitários
