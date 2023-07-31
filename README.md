# AtletaConnect

Este projeto é uma aplicação em Flutter que permite gerenciar informações sobre atletas e torneios. A aplicação possui diferentes telas, como a tela de login, a tela principal para cadastrar/atualizar atletas e torneios, e a tela para consultar os torneios cadastrados.

## Requisitos

Para executar este projeto, você precisará ter instalado o Flutter SDK e um ambiente de desenvolvimento Flutter configurado em seu computador.

## Como executar o projeto

1. Clone o repositório para o seu computador.

2. Abra o projeto em um editor de código, como o Visual Studio Code ou o Android Studio.

3. No terminal do editor de código, execute o comando `flutter pub get` para obter as dependências necessárias.

4. Conecte um dispositivo físico ou inicie um emulador Android/iOS.

5. Execute o comando `flutter run` no terminal para executar o aplicativo no dispositivo/emulador.

## Telas

### Tela de Login

- Na tela de login, o usuário pode inserir seu nome de usuário e senha para acessar a aplicação.
- Caso o usuário não possua uma conta, pode criar uma nova conta clicando em "Criar Conta".

### Tela de Cadastro de Atleta

- Após fazer login, o usuário será direcionado para a tela principal.
- Nesta tela, o usuário pode cadastrar novos atletas, fornecendo informações como nome, idade, esporte, entre outras.
- Os atletas cadastrados são exibidos em uma lista, onde é possível editar ou excluir cada atleta individualmente.

### Tela de Cadastro de Torneio

- A partir da tela principal, o usuário pode acessar a tela de cadastro de torneios clicando no botão "Avançar para Cadastrar Torneio".
- Nesta tela, o usuário pode cadastrar novos torneios, fornecendo informações como local, data, categoria, entre outras.
- Os torneios cadastrados são exibidos em uma lista, onde é possível editar ou excluir cada torneio individualmente.

### Tela de Consulta de Torneios

- A partir da tela principal, o usuário pode acessar a tela de consulta de torneios clicando no botão "Avançar para Consultar Torneios".
- Nesta tela, o usuário pode visualizar uma lista de todos os torneios cadastrados.

## Funcionalidades

- Cadastro e autenticação de usuários.
- Cadastro, edição e exclusão de atletas.
- Cadastro, edição e exclusão de torneios.
- Consulta de torneios cadastrados.

## Observação

Este projeto é focado apenas na construção da interface de usuário e das funcionalidades frontend do aplicativo. Não possui funcionalidades de backend (servidor) para armazenar os dados dos atletas e torneios de forma persistente. Portanto, todas as informações cadastradas serão armazenadas localmente no dispositivo e não estarão disponíveis em outros dispositivos ou após o encerramento do aplicativo.

Divirta-se usando a aplicação AtletaConnect 😊🏅🏀🎾


