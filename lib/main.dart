import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:five_by_five/firebase_options.dart';
import 'package:five_by_five/src/group/presentation/group_route.dart';
import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/player_card_list.dart';
import 'package:five_by_five/src/player/presentation/sign_in.dart';
import 'package:five_by_five/src/player/presentation/sign_up.dart';
import 'package:five_by_five/src/util/rank.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/signin' : '/',
      routes: {
        '/groups': (context) => GroupRoute(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
      },
      home: const Home(title: 'Five by Five'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Player> _playerList = List<Player>.empty(growable: true);
  bool isLoading = true;

  @override
  void initState() {
    _getPlayers();
    super.initState();
  }

  void _getPlayers() async {
    _playerList.addAll(await FirestorePlayerRepository.getPlayers());
    // if (_playerList.length <= 10) {
    //   for (var k = 0; k < 15; k++) {
    //     await _addRandomPlayer();
    //   }
    // }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _addRandomPlayer() async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    String getRandomString(int length) {
      Random _rnd = Random();
      return String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    }

    dynamic wordList = [getRandomString(10), getRandomString(6)];
    var rank = Rank.getRandomRank().rank;
    Player samplePlayer = Player.createPlayer({
      "playerId": wordList[0],
      "name": wordList[1],
      "currentRank": rank,
      "highestRank": rank,
      "mainLanes": Rank.getRandomLanes()
    });
    await FirestorePlayerRepository.addPlayer(player: samplePlayer);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator(
        strokeWidth: 5.0,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Players',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            if (FirebaseAuth.instance.currentUser != null)
              PlayerCardList(
                playerList: _playerList,
                displayForm: true,
              )
            else
              InkWell(
                child: Text(
                  "Please Sign In first!",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () => Navigator.pushReplacementNamed(context, "/signin"),
              )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPlayers,
        tooltip: 'Refresh List',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
