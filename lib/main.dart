import 'package:firebase_core/firebase_core.dart';
import 'package:five_by_five/firebase_options.dart';
import 'package:five_by_five/src/group/representation/group_route.dart';
import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/player_card_list.dart';
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
      routes: {
        '/groups': (context) => GroupRoute(),
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
  List<Player> _playerList = List<Player>.empty();
  bool isLoading = true;

  @override
  void initState() {
    _getPlayers();
    super.initState();
  }

  void _getPlayers() async {
    _playerList = await FirestorePlayerRepository.getPlayers();
    setState(() {
      isLoading = false;
    });
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
            PlayerCardList(playerList: _playerList, displayForm: true,)
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
