import 'package:entrevista_popcode/helpers/pessoa_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DataBaseHelper<T> {
  static final _databaseName = 'starwars.db';
  static final _databaseVersion = 1;

  Database _dataBase;

  Future<T> savePeople(T people);
  Future<T> getFirst(String nome);
  Future<List> getAll();
  Future<int> getRowCount();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;
    _dataBase = await _creatDatabase();
    return _dataBase;
  }

  Future<Database> _creatDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database db, int newVersion) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS ${PessoaHelper.tableName}(${PessoaHelper.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${PessoaHelper.nameColumn} TEXT, ${PessoaHelper.heightColumn} TEXT,${PessoaHelper.massColumn} TEXT, "
            "${PessoaHelper.hairColorColumn} TEXT, ${PessoaHelper.skinColorColumn} TEXT, "
            "${PessoaHelper.eyeColorColumn} TEXT, ${PessoaHelper.birthYearColumn} TEXT, "
            "${PessoaHelper.genderColumn} TEXT, ${PessoaHelper.homeWorldColumn} TEXTE, "
            "${PessoaHelper.specieColumn} TEXT)");
      },
    );
  }
}
