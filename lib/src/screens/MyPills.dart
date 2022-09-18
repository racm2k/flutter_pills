import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Pill.dart';

class MyPillsPage extends StatefulWidget {
  const MyPillsPage({Key? key}) : super(key: key);

  @override
  State<MyPillsPage> createState() => _MyPillsPageState();
}

class _MyPillsPageState extends State<MyPillsPage> {
  late List<Pill> pills = [];

  Future<List<Pill>> getPills() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    pills = Pill.decode(prefs.getString('myPillsKey') ?? '');
    return pills;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPills();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPills(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: pills.length,
            itemBuilder: (context, index) {
              Pill pill = pills[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(pill.name),
                    subtitle: Text(pill.brand),
                    trailing: const Icon(
                      Icons.notification_add,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
