# Flutter - Persistência de Dados com o Pacote Moor

## Referências
https://pub.dev/packages/moor_flutter

### Guia

- Adicionar as dependências no arquivo `pubspec.yaml`:
```yml
dependencies:
  flutter:
    sdk: flutter
  # framework sqlite: https://pub.dev/packages/moor_flutter
  moor_flutter: ^1.4.0
  # framework UI
  provider: ^3.0.0+1
  flutter_slidable: ^0.5.3

  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  ## outros pacotes adicionados
  moor_generator: ^1.4.0
  build_runner:

```

- Após digitar o seguinte código no arquivo `data/database.dart`:

```dart
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(): super(FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true, 
  ));
}
```
- Rode o comando:

```bash
    cd fluttermoor/

    flutter packages pub run build_runner watch
```