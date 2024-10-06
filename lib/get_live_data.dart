import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mach_managed/add_data_in%20_sheet.dart';
import 'package:mach_managed/user/auth.dart';

//void main() => runApp(const MaterialApp(home: LiveSheetData()));

class LiveSheetData extends StatefulWidget {
  const LiveSheetData({super.key});

  @override
  State<LiveSheetData> createState() => _LiveSheetDataState();
}

class _LiveSheetDataState extends State<LiveSheetData> {
  Stream<List<dynamic>>? _dataStream;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _dataStream = _fetchLiveData();
  }

  // Function to fetch live data every 5 seconds
  Stream<List<dynamic>> _fetchLiveData() async* {
    while (true) {
      final response = await http.get(
        Uri.parse('https://script.google.com/macros/s/AKfycby4xybXPneb56ZeRMPiBdaASpebIBnoq3vcBAAw4ZH8AjBBChlMik-mjjwQbPtA73bQnw/exec'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _scrollToBottom();
        yield data;
      } else {
        throw Exception('Failed to load data');
      }
      await Future.delayed(const Duration(milliseconds: 300));  // Polling every 5 seconds
    }
  }
  // Function to auto-scroll to the bottom
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Google Sheet Data'),actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddCharacterScreen()));
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AuthPage()));
          },
          icon: const Icon(Icons.person),
        )
      ],),
      body: StreamBuilder<List<dynamic>>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              controller: _scrollController,
              itemCount: data.length,
              reverse: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['Name'].toString()),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index]['Phone'].toString()),
                      Text(data[index]['Address']),
                      const Divider(),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}


