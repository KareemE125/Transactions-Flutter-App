import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:max_course/models/dailyTransaction.dart';

const String tableName = 'myTransactions';

Future<Database> _createDB() async{
  /// join() => Joins the given path parts into a single path from 'package:path/path.dart'
  /// where we Joins the 'Databases Path' => getDatabasesPath() & 'friends.db' into single path
  String path = join(await getDatabasesPath(),'transactions.db');

  Database _db = await openDatabase(path, version: 1, onCreate: _onCreate);

  return _db;
}

void _onCreate(Database db, int version) async{
  await db.execute('create table $tableName(id integer primary key autoIncrement, title varchar(50), price REAL not null, date varchar(30) not null )');
}

void addTransaction(DailyTransaction t) async
{
  Database db =  await _createDB();
  await db.insert(tableName, {'title': t.title, 'price': t.price, 'date': t.dateTime.toString() });
}


void deleteTransaction(int sentId) async
{
  Database db =  await _createDB();
  await db.delete(tableName, where: 'id=?', whereArgs: [sentId]);
}

Future<List> getAllTransactions() async
{
  Database db =  await _createDB();
  return await db.query(tableName);

  ///to write sql query for the selection use =>
  ///my_db.rawQuery('select * from courses');
}