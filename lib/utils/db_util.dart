import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../common/constant.dart';

class DBUtil {
  //单例对象
  static final DBUtil _instance = DBUtil._internal();
  //获取单例内部方法
  factory DBUtil() => _instance;
  //内部构造方法, 避免外部暴露构造函数, 进行实例化
  DBUtil._internal(); //私有构造函数（命名构造函数）

  static const _version = 1; //数据库版本
  static const articleTable = 'article';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  initDB() async {
    //本地路径 /data/data/com.example.flutter_getx/app_flutter
    //Directory directory = await getApplicationDocumentsDirectory();

    //本地路径 /data/data/com.example.flutter_getx/databases
    var dbPath = await getDatabasesPath();
    //数据库名称
    String dbName = Constant.DB_NAME;
    String path = join(dbPath, dbName);
    return await openDatabase(
        path,
        version: _version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }

  //创建表
  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $articleTable (
      id INTEGER PRIMARY KEY,
      catid INTEGER NOT NULL,
      title TEXT NOT NULL,
      info TEXT NOT NULL,
      content TEXT NOT NULL,
      img TEXT NOT NULL,
      author TEXT NOT NULL,
      sort INTEGER NOT NULL,
      status INTEGER NOT NULL
    )
    ''');
  }

  //更新表
  _onUpgrade(Database db, int oldVersion, int newVersion) {}
}