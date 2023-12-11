# pior_filme

Projeto Mobile Flutter cujo objetivo é listar os vencedores da categoria Pior Filme do Golden Raspberry Awards.

### Especificações técnicas

- Flutter 3.16.3
- VsCode com a extensão `Flutter` e `Dart`

### Como rodar o projeto

- Clonar o repositório
    - Branch principal: main
- Rodar o comando `dart pub get` para instalar as dependências
- Se estiver no VsCode, rodar com o atalho `F5`
    - É necessário ter um emulador android ou IOS, ou um celular conectado para rodar

### Como testar o projeto

- Rodar o comando `flutter test` para rodar e acompanhar os testes.

### Arquitetura

Esse projeto usa o padrão **MVC+S** de arquitetura, contando com uma camada de domínio (`models`), uma camada de apresentação (`pages`), uma camada de serviço (`repositories`) e uma camada de controle (`controllers`). As camadas foram divididas em funcionalidades para facilitar a escalabilidade.

Também foi criada uma camada chamada de compartilhamento (`shared`) que fica responsável por armazenar os recursos (widgets, enums...) reutilizáveis.

Para ajudar na escalabilidade, foram criados alguns widgets com a sigla `Pf` que podem ser reutilizados, como, por exemplo, o `Filtro por ano`, que pode ser reutilizado em várias pages, como foi o caso do `Dashboard` e da `Movie List`.

### Estrutura de arquivos

```
├── lib
│   ├── controllers
│   │   ├── dashboard
│   │   ├── home
│   │   └── movie
│   ├── models
│   │   ├── app
│   │   └── movie
│   ├── pages
│   │   ├── dashboard
│   │   ├── home
│   │   └── movie
│   ├── repositories
│   │   └── movie
│   ├── shared
│   │   ├── enums
│   │   ├── environment
│   │   ├── utils
│   │   └── widgets
```
