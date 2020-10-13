# Scholarship Offers

> Api de ofertas de bolsas escolares.

O Scholarship Offers reúne bolsas de estudo em mais de 6.000 parceiros entre faculdades e escolas de todo o Brasil.

Você pode buscar escolas e cursos de graduação, pós-graduação, idiomas e técnico em qualquer região, pesquisar e comparar os preços das mensalidades, ver informações sobre as instituições e ainda garantir uma bolsa de estudo sem burocracia.

## Modelo  

![](https://i.ibb.co/1Tz2wKP/scholarship-offers.png)

## Instalação

**Usando Docker & docker-compose**

Construindo a image do projeto com o comando build:  
`docker-compose build scholarship_offers`

Configurando o banco de dados (O comando abaixo irá apaga o banco de dados atual):  
`docker-compose run --rm scholarship_offers rails db:dev:populate`

A partir da versão 5.2 do Rails, foi introduzido a ferramenta [Credentials](https://edgeguides.rubyonrails.org/security.html#environmental-security). Para gerar a SECRET_BASE_KEY, é necessário executar o seguinte comando:  
`docker-compose run --rm -e EDITOR=vim id-service bin/rails credentials:edit`

Execute o comando up para subir a aplicação:  
`docker-compose up scholarship_offers`

![](https://memegenerator.net/img/instances/82338138.jpg)

## Realizando o login

Para acesso de recursos do Scholarship Offers usa como autenticação o padrão JWT. Para tal é necessário efetuar o login enviando no corpo da requisição em formato JSON email e senha. Será retornado um header Authorization contendo o token no formato JWT na request.

| Parametro | Descrição                                 |
| --------- | ----------------------------------------- |
| email     | O email cadastrado (user@scholarship.com) |
| password  | A senha cadastrada (123456)               |

#### Exemplo:

`/login`

## Realizando buscas

### Cursos

| Parametro | Descrição                                                       |
| --------- | --------------------------------------------------------------- |
| name      | Nome do curso                                                   |
| kind      | Tipo do curso (Presencial/EaD )                                 |
| level     | Tipo da graduação. Ex: Bacharelado                              |
| shift     | Período escolar. (Matutino/Vespertino/Nortuno/Integral/Virtual) |

#### Exemplo:

`/courses?name=Artes&kind=EaD&shift=Virtual`

### Ofertas

| Parametro       | Descrição                                                       |
| --------------- | --------------------------------------------------------------- |
| university_name | Nome da escola ou parceiro                                      |
| campus_city     | Nome do campus                                                  |
| course_name     | Nome do curso                                                   |
| course_kind     | Tipo do curso (Presencial/EaD                                   |
| course_level    | Tipo da graduação. Ex: Bacharelado                              |
| course_shift    | Período escolar. (Matutino/Vespertino/Nortuno/Integral/Virtual) |

#### Exemplo de uso:

`/offers?university_name=Fartes&course_kind=EaD&`

## Rodando os testes

`docker-compose run -e "RAILS_ENV=test" --rm scholarship_offers bundle exec rspec`
