# MovieFinder - iOS App

**[Tela Home]**  
<img src="https://i.imgur.com/T5ONrQz.png" width="300" alt="Tela Home">

## Descrição
MovieFinder é um aplicativo iOS que permite aos usuários buscar e visualizar informações sobre filmes. O app foi desenvolvido como parte de um teste técnico para uma vaga de desenvolvimento mobile iOS.

## Características Principais
- Desenvolvido completamente em **ViewCode**
- Adoção dos princípios **SOLID**
- **Acessibilidade** implementada em todo o projeto
- Reatividade através de **delegates**
- **Animações** em ViewCode
- Configuração para uso de **mock ou API real** através do esquema do Xcode
- Extensões úteis para desenvolvimento
- Sem leaks de memória (utilização do Instruments para diagnóstico)

## Decisões Técnicas
- **ViewCode**: O app foi desenvolvido totalmente em ViewCode.
- **SOLID**: Segui os princípios SOLID para aumentar a manutenibilidade e testabilidade do código.
- **Acessibilidade**: Recursos de acessibilidade foram implementados em todo o app para atender às necessidades de usuários com deficiência visual.
- **Reatividade**: Utilização de delegates para gerenciar a reatividade do app.
- **Configuração de Ambiente**: Criado um `APPConfig` para gerenciar o uso de mock ou API real, dependendo da configuração do Xcode Scheme.
- **Separação de Responsabilidades**: Serviços distintos para decodificação JSON e gerenciamento de chamadas à API da TMDB.
- **Customização**: Desenvolvimento de um `CustomAlert` e `StatsView` reutilizáveis, além de várias extensões úteis para facilitar o desenvolvimento.
- **Documentação**: As funções foram documentadas seguindo o padrão da Apple, permitindo que os comentários sejam exibidos de forma clara e estruturada ao utilizar a combinação **Option + Click** sobre uma função.
- **Animações**: Segui de perto as animações do app de inspiração. Além disso, uma extensão foi adicionada ao `ButtonStyle` da Apple para suportar um efeito de "bounce", aplicado em botões de ação. No UIKit, animações foram implementadas para mudanças dinâmicas na interface.

## Testes
- **Testes Unitários**:  
  Foram implementados testes unitários nas classes de ViewModel do app, utilizando **mocks** e **spies**. Graças à abstração via protocolos, foi possível isolar as dependências e testar cada componente de forma independente.
  
- **Testes End-to-End (E2E)**:  
  Os testes de fluxo completo foram construídos utilizando a estratégia de **Pages**, garantindo clareza, reutilização e manutenibilidade na automação dos cenários críticos de navegação e interação do usuário.

## Como Executar o App
1. Toque no botão **"Vamos lá!"** na tela inicial.  
2. Na tela de filmes, você verá os detalhes do filme, com os filmes relacionados logo abaixo.  

---

**[Tela MovieDetails]**  
<img src="https://i.imgur.com/EJYWrIn.png" width="300" alt="Tela MovieDetails">

**[Leaks]**  
<img src="https://i.imgur.com/SKVGzOM.png" width="900" alt="Leaks">  
_App sem vazamentos de memória_

---

## Instalação
Clone o repositório:
```bash
git clone [https://github.com/bruunomooura/movieFinder.git](https://github.com/bruunomooura/movieFinder.git)
