# Scholarship Offers

> Api de ofertas de bolsas escolares.

O Scholarship Offers reúne bolsas de estudo em mais de 6.000 parceiros entre faculdades e escolas de todo o Brasil.

Você pode buscar escolas e cursos de graduação, pós-graduação, idiomas e técnico em qualquer região, pesquisar e comparar os preços das mensalidades, ver informações sobre as instituições e ainda garantir uma bolsa de estudo sem burocracia.

## Instalação

**Usando Docker & docker-compose**

Construindo a image do projeto com o comando build:  
`docker-compose build scholarship_offers`

Configurando o banco de dados:
`docker-compose run --rm scholarship_offers rails db:dev:populate`

A partir da versão 5.2 do Rails, foi introduzido a ferramenta [Credentials](https://edgeguides.rubyonrails.org/security.html#environmental-security). Para gerar a SECRET_BASE_KEY, é necessário executar o seguinte comando:  
`docker-compose run --rm -e EDITOR=vim id-service bin/rails credentials:edit`

Executar o comando up:  
`docker-compose up scholarship_offers`

![](https://images.app.goo.gl/TeXSa8PLY3hcKNYM8)

Para acesso de recursos do Scholarship Offers usa como autenticação o padrão JWT

##Realizando a busca de cursos ou ofertas

### Cursos

| Parametro | Descrição                                                       |
| --------- | --------------------------------------------------------------- |
| name      | Nome do curso                                                   |
| kind      | Tipo do curso (Presencial/EaD                                   |
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
