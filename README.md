# Instalação do Flutter no Linux

- Download: https://flutter.dev/docs/get-started/install/linux

```bash
    # Descomprimir
    tar xf flutter_linux_v1.12.13+hotfix.7-stable.tar.xz

    # Mover para o diretório `usr/local`
    sudo mv flutter /usr/local/

    # Adicionar o executável do flutter ao PATH do sistema
    export PATH="$PATH:/usr/local/flutter/bin"

    # Rodar os comandos 
    flutter precache

    # este comando mostra quais dependências ainda são necessárias para trabalhar com Flutter
    flutter doctor
```

## Emuladores do Android Studio

> Após ter baixado e instalado o Android Studio, configure um emulador

```bash
    # listar os emuladores configurados
    cd $HOME/Android/Sdk/emulator && ./emulator -list-avds

    # rodar um emulador
    cd $HOME/Android/Sdk/emulator && ./emulator -avd [Nome do Emulador]
```

## Criar e Rodar um APP

```bash
    # criar um app
    flutter create myapp

    # rodar o app
    flutter run
```

## Formatar um arquivo do projeto

```bash
    flutter format <filename>
```

> Quando o código for alterado, é necessário clicar na tecla __`[R]`__ para o aplicativo refletir as alterações

## Baixar as Depêndencias definidas no pubspec.yaml

```bash
    flutter pub get
```
