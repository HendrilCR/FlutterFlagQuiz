Aqui está um exemplo de como o `README.md` pode ser estruturado para o seu projeto de jogo de adivinhar bandeiras em Flutter:

---

# Jogo de Adivinhar Bandeiras

Este é um projeto de jogo desenvolvido em Flutter, onde o objetivo é adivinhar o nome de um país a partir de sua bandeira. O jogo apresenta uma bandeira na tela e oferece quatro opções de países. O jogador deve escolher a opção correta para ganhar pontos. As bandeiras e os nomes dos países são carregados de um arquivo JSON localizado na pasta do projeto.

## Funcionalidades

- **Tela inicial com quatro opções de tempo:** O jogador pode escolher o tempo limite para a partida: 15, 30, 45 ou 60 segundos, cada um com uma cor diferente.
- **Pontuação:** O jogador ganha um ponto a cada resposta correta. A pontuação final é exibida ao fim do tempo.
- **Banco de dados de bandeiras:** As bandeiras e nomes dos países são adquiridos de um arquivo JSON localizado na pasta do projeto.

## Como Rodar o Projeto

### Pré-requisitos

- [Flutter](https://flutter.dev/docs/get-started/install) instalado.
- [Dart](https://dart.dev/get-dart) instalado.

### Passos

1. Clone este repositório para sua máquina local:

    ```bash
    git clone https://github.com/seu-usuario/nome-do-repositorio.git
    ```

2. Navegue até o diretório do projeto:

    ```bash
    cd nome-do-repositorio
    ```

3. Instale as dependências:

    ```bash
    flutter pub get
    ```

4. Execute o aplicativo:

    ```bash
    flutter run
    ```

### Estrutura do Projeto

- **lib/**
  - `main.dart`: Arquivo principal onde o app é inicializado.
  - `screens/`: Contém as telas do aplicativo, incluindo a tela inicial e a tela de jogo.
  - `widgets/`: Contém os widgets reutilizáveis, como botões e contadores de tempo.
  - `models/`: Contém modelos para as bandeiras e países.
- **assets/**
  - `flags.json`: Arquivo JSON que contém os dados das bandeiras e nomes dos países.
  - `images/`: Imagens das bandeiras.

## Como Funciona o Jogo

1. Ao iniciar o jogo, o usuário escolhe entre quatro opções de tempo: 15, 30, 45 ou 60 segundos, cada uma com uma cor diferente.
2. Uma bandeira é exibida e quatro opções de países são mostradas na tela.
3. O jogador deve escolher o país correto que corresponde à bandeira exibida. Se acertar, ganha um ponto.
4. O jogo continua até que o tempo escolhido acabe, momento em que a pontuação final é exibida.

## Contribuindo

1. Faça um fork deste repositório.
2. Crie uma nova branch para suas alterações (`git checkout -b minha-nova-feature`).
3. Faça suas alterações.
4. Envie suas alterações para o repositório remoto (`git push origin minha-nova-feature`).
5. Crie um pull request para revisar suas alterações.

## Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

---

Esse `README.md` oferece uma visão geral do projeto, instruções de uso, estrutura de arquivos e como o jogo funciona. Você pode adicionar ou modificar conforme necessário, dependendo de mais detalhes do seu projeto!
