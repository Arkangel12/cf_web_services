import 'package:cf_web_services/album.dart';
import 'package:cf_web_services/api_calls.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album> futureAlbum;
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    futureAlbums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


// body: FutureBuilder<List<Album>>(
// future: futureAlbums,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// final albums = snapshot.data!;
//
// return ListView.builder(
// itemCount: albums.length,
// itemBuilder: (_, index) {
// final album = albums![index];
// return ListTile(
// leading: Text('${album.id}'),
// title: Text(album.title),
// );
// });
// //return Text(snapshot.data!.title);
// } else if (snapshot.hasError) {
// return Text('${snapshot.error}');
// }
//
// // By default, show a loading spinner.
// return const CircularProgressIndicator();
// },
// ),