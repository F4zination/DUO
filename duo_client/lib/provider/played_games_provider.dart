import 'package:duo_client/utils/models/played_game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PlayedGamesProvider extends ChangeNotifier {
  List<PlayedGame> _playedGames = [
    PlayedGame(
      id: 1,
      gameType: 'Duo',
      amountofPlayers: 5,
      score: 100,
      duration: const Duration(minutes: 10),
      date: DateTime.now(),
      placement: 1,
    ),
    PlayedGame(
      id: 2,
      gameType: 'Duo',
      amountofPlayers: 6,
      score: 100,
      duration: const Duration(minutes: 10),
      date: DateTime.now(),
      placement: 5,
    ),
    PlayedGame(
      id: 3,
      gameType: 'Duo',
      amountofPlayers: 4,
      score: 100,
      duration: const Duration(minutes: 10),
      date: DateTime.now(),
      placement: 3,
    ),
  ];

  void addGame(PlayedGame game) async {
    insertToDb(game);
    await fetchFromDb();
    notifyListeners();
  }

  Future<Database?> openDb() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      '$path/played_games.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE played_games(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gameType TEXT,
            amountofPlayers INTEGER,
            score INTEGER,
            duration INTEGER,
            date DATE,
            placement INTEGER
          )''',
        );
      },
    );
  }

  Future<void> fetchFromDb() async {
    final Database? db = await openDb();
    final List<Map<String, dynamic>> games = await db!.query('played_games');
    _playedGames = games.map((game) => PlayedGame.fromMap(game)).toList();
  }

  Future<void> insertToDb(PlayedGame game) async {
    final Database? db = await openDb();
    await db!.insert('played_games', game.toMap());
  }

  Future<void> deleteFromDb(int id) async {
    final Database? db = await openDb();
    await db!.delete(
      'played_games',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void removeGame(int id) async {
    await deleteFromDb(id);
    await fetchFromDb();
    notifyListeners();
  }

  List<PlayedGame> get playedGames {
    return _playedGames;
  }

  PlayedGamesProvider();
}

final playedGamesProvider =
    ChangeNotifierProvider((ref) => PlayedGamesProvider());
