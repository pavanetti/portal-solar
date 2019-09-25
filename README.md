# Executando a aplicação Portal Solar

A aplicação roda em um container docker. A imagem é criada em dois estágios para reduzir o tamanho da imagem final de produção. O primeiro estágio instala as dependências e compila os assets. Os comandos estão dispostos de maneira a aproveitar ao máximo as camadas anteriores.

## Iniciando os containeres

Crie um arquivo com o nome .env e o seguinte conteúdo:

```
RAILS_SERVE_STATIC_FILES="true"
```

Caso haja um servidor nginx/apache servindo os assets estáticos, a variável de ambiente acima é desnecessária. Mas o arquivo pode ser usado para passar outras variáveis de ambiente para a aplicação que não devam estar no repositório.

Para iniciar a aplicação, junto com o serviço de banco de dados, execute o comando `docker-compose` como abaixo:

```
$ docker-compose up -d
```

A aplicação estará disponível na porta 3000 da máquina. O build da imagem pode ser disparado durante o processo caso não tenha uma imagem já cacheada.

## Criando e populando o banco de dados

Na primeira execucação pode ser necessário criar o banco de dados e realizar as migrações. Nesse caso, execute os comandos `docker-compose run` como abaixo:

```
$ docker-compose run portal bundle exec rails db:create
$ docker-compose run portal bundle exec rails db:migrate
$ docker-compose run portal bundle exec rails db:seed
```
