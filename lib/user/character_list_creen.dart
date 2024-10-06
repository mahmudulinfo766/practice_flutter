import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mach_managed/user/auth.dart';
import 'package:http/http.dart' as http;
import '../add_data_in _sheet.dart';



class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    ApiService apiService = ApiService();
    futureCharacters = apiService
        .fetchCharacters(); // Fetch the data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNES Characters'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddCharacterScreen()));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AuthPage()));
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ApiService apiService = ApiService();
          futureCharacters = apiService.fetchCharacters();
          return futureCharacters;
        },
        child: FutureBuilder<List<Character>>(
          future: futureCharacters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found'));
            } else {
              // Display the data in a ListView
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Character character = snapshot.data![index];
                  return ListTile(
                    title: Text(character.name.toString()),
                    subtitle: Text('${character.phone} - ${character.address}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class Character {
  final dynamic name;
  final dynamic phone;
  final String? address;

  Character({required this.name, required this.phone, required this.address});

  // Factory constructor to create a Character from a JSON object
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['Name'],
      phone: json['Phone'],
      address: json['Address'],
    );
  }
}

class ApiService {
  final String apiUrl =
      'https://script.google.com/macros/s/AKfycby4xybXPneb56ZeRMPiBdaASpebIBnoq3vcBAAw4ZH8AjBBChlMik-mjjwQbPtA73bQnw/exec'; // Replace with your Google Apps Script API URL

  // Method to fetch data from API
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      // Convert the JSON response to a list of Character objects
      return jsonResponse.map((data) => Character.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}