import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character.dart';

Future<Character> fetchCharacter() async {
  final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/1'));

  if (response.statusCode == 200) {
    return Character.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('ERROR AL CARGAR EL PERSONAJE ');
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty API EJEMPLO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Character> futureCharacter;

  @override
  void initState() {
    super.initState();
    futureCharacter = fetchCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty API EJEMPLO'),
      ),
      body: Center(
        child: FutureBuilder<Character>(
          future: futureCharacter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(snapshot.data!.imageUrl),
                  Text(
                    snapshot.data!.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text('ESTADOR: ${snapshot.data!.status}'),
                  Text('ESPECIES: ${snapshot.data!.species}'),
                  Text('GENERO: ${snapshot.data!.gender}'),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
