# Nubank Shorten Links

Aplicativo Flutter para encurtar links, desenvolvido como teste técnico para o Nubank.

## 📋 Descrição

Este projeto é um aplicativo mobile desenvolvido em Flutter que permite aos usuários encurtar URLs longas. O aplicativo possui suporte a múltiplos idiomas (Português e Inglês) e utiliza arquitetura modular com gerenciamento de estado usando MobX.

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Flutter SDK**
  - Verifique a instalação: `flutter --version`
  - Instruções de instalação: [Flutter Install](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (incluído com o Flutter)
- **Android Studio** ou **VS Code** com extensões do Flutter

### Para desenvolvimento Android:
- Android SDK
- Android Studio ou Android SDK Command-line Tools

### Para desenvolvimento iOS (apenas macOS):
- Xcode
- CocoaPods

## 🚀 Instalação


1. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

2. **Gere os arquivos de código:**
   
   O projeto utiliza code generation para MobX e traduções. Execute os seguintes comandos:
   
   ```bash
   # Gerar código MobX
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Gerar arquivos de tradução
   flutter pub run intl_utils:generate
   ```

## ▶️ Como Executar

### Executar no dispositivo/emulador:

1. **Verifique os dispositivos disponíveis:**
   ```bash
   flutter devices
   ```

2. **Execute o aplicativo:**
   ```bash
   flutter run
   ```
   
## 🧪 Testes

```bash
# Executar testes unitários
flutter test

# Executar testes de integração
flutter test integration_test/
```

## 📁 Estrutura do Projeto

```
lib/
├── assets/              # Recursos estáticos (imagens)
├── generated/           # Arquivos gerados automaticamente
│   ├── intl/           # Arquivos de tradução gerados
│   └── l10n.dart       # Classe de localização
├── l10n/               # Arquivos de tradução (.arb)
├── main.dart           # Ponto de entrada da aplicação
└── modules/
    ├── core/           # Módulo core (configurações, HTTP, etc)
    ├── design/         # Componentes de UI reutilizáveis
    └── link_shortener/ # Módulo principal do encurtador de links
        ├── models/     # Modelos de dados
        ├── stores/     # Stores MobX
        ├── use_cases/  # Casos de uso
        └── views/      # Telas e widgets
```

## 🏗️ Arquitetura

O projeto utiliza:

- **Flutter Modular**: Para injeção de dependências e roteamento
- **MobX**: Para gerenciamento de estado reativo
- **Clean Architecture**: Separação em camadas (Views, Stores, Use Cases)
- **Internationalization (i18n)**: Suporte a múltiplos idiomas

