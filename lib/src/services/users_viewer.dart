import 'package:cf_web_services/src/models/user.dart';
import 'package:cf_web_services/src/services/api_calls.dart';
import 'package:flutter/material.dart';

class UsersViewer extends StatefulWidget {
  const UsersViewer({super.key});

  @override
  State<UsersViewer> createState() => _UsersViewerState();
}

class _UsersViewerState extends State<UsersViewer> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
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
        floatingActionButton: FloatingActionButton(onPressed: (){setState(() {
          print("hola");

        });},),
        body: FutureBuilder<List<User>>(
          future: fetchUsers(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    final user = users[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child:Text('${user.id}'),
                      ),
                      title: Text('${user.name} - ${user.website}'),
                      subtitle: Text(user.company.name.toUpperCase()),
                      trailing: const Icon(Icons.person),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
