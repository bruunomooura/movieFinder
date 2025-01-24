# MovieFinder - iOS App

**[Tela Home]**

<img src="https://i.imgur.com/T5ONrQz.png" width="300" alt="Tela Home">

Descrição
MovieFinder é um aplicativo iOS que permite aos usuários buscar e visualizar informações sobre filmes. O app foi desenvolvido como parte de um teste técnico para uma vaga de desenvolvimento mobile iOS.

Características Principais

Desenvolvido completamente em ViewCode
Adoção dos princípios SOLID
Acessibilidade implementada em todo o projeto
Reatividade através de delegates
Animações em ViewCode
Configuração para uso de mock ou API real através do esquema do Xcode
Extensões úteis para desenvolvimento
Sem leaks de memória (utilização do Instruments para diagnóstico)
Decisões Técnicas

ViewCode: O app foi desenvolvido totalmente em ViewCode, com componentes em SwiftUI para demonstrar a integração entre as duas abordagens.

SOLID: Segui os princípios SOLID para aumentar a manutenibilidade e testabilidade do código.

Acessibilidade: Recursos de acessibilidade foram implementados em todo o app para atender às necessidades de usuários com deficiência visual.

Reatividade: Utilização de delegates para gerenciar a reatividade do app.

Configuração de Ambiente: Criado um APPConfig para gerenciar o uso de mock ou API real, dependendo da configuração do Xcode Scheme.

Separação de Responsabilidades: Serviços distintos para decodificação JSON e gerenciamento de chamadas à API da TMDB.

Customização: Desenvolvimento de um CustomAlert e StatsView reutilizáveis, além de várias extensões úteis para facilitar o desenvolvimento.

Documentação: As funções foram documentadas seguindo o padrão da Apple, permitindo que os comentários sejam exibidos de forma clara e estruturada ao utilizar a combinação Option + click sobre uma função.

Animações: Segui de perto as animações do app de inspiração. Além disso, uma extensão foi adicionada ao ButtonStyle da Apple para suportar um efeito de "bounce", aplicado em botões de ação. No UIKit, animações foram implementadas para mudanças dinâmicas na interface.

Como Executar o App

Toque no botão "Vamos lá!" na tela inicial.
Na tela de filmes, você verá os detalhes do filme, com os filmes relacionados logo abaixo.
Como Executar o App

**[Tela MovieDetails]**

<img src="https://i.imgur.com/EJYWrIn.png" width="300" alt="Tela MovieDetails">

Instalação

Clone o repositório:

```bash
git clone https://github.com/bruunomooura/movieFinder.git
```

Abra o arquivo MovieFinder.xcodeproj no Xcode.

Selecione o simulador ou dispositivo de destino.

Execute o app (⌘ + R).
