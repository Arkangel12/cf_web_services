import 'package:cf_web_services/src/models/album.dart';
import 'package:cf_web_services/src/services/api_calls.dart';
import 'package:cf_web_services/src/models/user.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album> futureAlbum;
  late Future<List<Album>> futureAlbums;
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    futureAlbums = fetchAlbums();
    futureUser = fetchUser();
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
        body: FutureBuilder<List<Album>>(
          future: futureAlbums,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final albums = snapshot.data!;

              return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (_, index) {
                    final album = albums[index];

                    return ListTile(
                      leading: Text('${album.id}'),
                      title: Text(album.title),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
        // body: Center(
        //   child: FutureBuilder<Album>(
        //     future: futureAlbum,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.title);
        //       } else if (snapshot.hasError) {
        //         return Text('${snapshot.error}');
        //       }
        //
        //       // By default, show a loading spinner.
        //       return const CircularProgressIndicator();
        //     },
        //   ),
        // ),
      ),
    );
  }
}