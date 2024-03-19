import 'package:chat_sqlite/model/conversation_message_model.dart';
import 'package:chat_sqlite/model/conversation_model.dart';
import 'package:chat_sqlite/model/message_model.dart';
import 'package:chat_sqlite/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DataBaseHelper{

  final dataBaseName = 'msgApp.db';

  //register user - create table query
  final registerUserTable = 'CREATE TABLE registerUser'
      '(userId INTEGER PRIMARY KEY AUTOINCREMENT,'
      'userName TEXT NOT NULL,'
      'userCreationTime TEXT NOT NULL,'
      'userPassword TEXT NOT NULL)';

  final conversationTable = 'CREATE TABLE conversation'
      '(conversationId INTEGER PRIMARY KEY AUTOINCREMENT,'
      'senderId INTEGER NOT NULL,'
      'receiverId INTEGER NOT NULL,'
      'conversationDate TEXT NOT NULL,'
      'conversationTime TEXT NOT NULL)';

  final messageTable = 'CREATE TABLE message'
      '(messageId INTEGER PRIMARY KEY AUTOINCREMENT,'
      'conversationId INTEGER NOT NULL,'
      'senderId INTEGER NOT NULL,'
      'receiverId INTEGER NOT NULL,'
      'messages TEXT NOT NULL,'
      'messageDate TEXT NOT NULL,'
      'messageTime TEXT NOT NULL)';

  ///table creation
  void _createTables(Database db) async{
    await db.execute(registerUserTable);
    await db.execute(conversationTable);
    await db.execute(messageTable);
  }

  Future<Database> initDB() async{
      final dbPath = getDatabasesPath().toString();
      final path = join(dbPath, dataBaseName);
      return openDatabase(path, version: 1, onCreate: (db, version) => _createTables(db));
  }


  ///register user - insertion query
  Future<int> insertRegisterUserData(UserModel userModel) async{
      final Database db = await initDB();
      return db.insert('registerUser', userModel.toJson());
  }

  ///register user - read query
  Future<List<UserModel>> readRegisterUserData() async{
    final Database db = await initDB();
    final List<Map<String, Object?>> result = await db.query('registerUser');
    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  ///register user - updation query
  Future<int> updateRegisterUserData(UserModel userModel) async{
    final Database db = await initDB();
    return db.rawUpdate('update registerUser set userName = ? where userId = ?',
          [userModel.userName, userModel.userId]);
  }

  ///register user - deletion query
  Future<int> deleteRegisterUserData(int userId) async{
    final Database db = await initDB();
    return db.delete('registerUser',where: 'userId = ?', whereArgs: [userId]);
  }

  ///receiver side : display all user accept sender
  Future<List<UserModel>> readRegisterUserDataAcceptSender(int userId) async{
    final Database db = await initDB();
    final List<Map<String, Object?>> result = await db.rawQuery('SELECT userId, userName from registerUser where userId != ?',[userId]);
    return result.map((e) => UserModel.fromJson(e)).toList();
  }




  ///ConversationTable
 ///Conversation - insertion query
  Future<int> insertConversation(ConversationModel conversationModel) async{
      final Database db = await initDB();
      return db.insert('conversation',conversationModel.toJson());
  }

  //it return true if the senderID and receiverID are already inserted in conversation table, otherwise return false
  Future<List<Map<String, Object?>>> readSpecificDataInConversation(int senderId, int receiverId) async{
    final Database db = await initDB();
    final List<Map<String, Object?>> result =  await db.query('conversation',
      where: '(senderId=? AND receiverId=?) OR (senderId=? AND receiverId=?)',
      whereArgs: [senderId, receiverId, receiverId, senderId],
    );
    return result;
  }


  ///Conversation - read query
  // Future<List<ConversationModel>> readConversation() async{
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>> result = await db.query('conversation');
  //   return result.map((e) => ConversationModel.fromJson(e)).toList();
  // }

  ///Conversation - deletion query
  // Future<int> deleteConversation(int conversationId) async{
  //   final Database db = await initDB();
  //   return db.delete('conversation',where: 'conversationId = ?', whereArgs: [conversationId]);
  // }



  ///Message table
  ///message table : insertion
  Future<int> insertMessage(MessageModel messageModel) async{
        final Database db = await initDB();
        return db.insert('message',messageModel.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///message table : read
  // Future<List<MessageModel>> readMessage() async{
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>> result = await db.rawQuery('SELECT *FROM message');
  //   return result.map((e) => MessageModel.fromJson(e)).toList();
  // }


  Future<List<MessageModel>> readMessages(int conversationId) async{
    final Database db = await initDB();
    final List<Map<String, Object?>> result = await db.rawQuery('SELECT *FROM message where conversationId = ?',[conversationId]);
    return result.map((e) => MessageModel.fromJson(e)).toList();
  }

  ///message table : delete one message
  Future<int> deleteOneMessage(int msgId) async{
    final Database db = await initDB();
    return db.delete('message',where: 'messageId = ?', whereArgs: [msgId]);
  }

  ///message table : delete all messages
  Future<List<Map<String, Object?>>> deleteAllMessages(int conversationId) async{
    final Database db = await initDB();
    return db.rawQuery('DELETE from message where conversationId = ?',[conversationId]);
  }


}