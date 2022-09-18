import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Pill.dart';

class SearchPillsPage extends StatefulWidget {
  const SearchPillsPage({Key? key}) : super(key: key);

  @override
  State<SearchPillsPage> createState() => _SearchPillsPageState();
}

class _SearchPillsPageState extends State<SearchPillsPage> {
  TextEditingController controller = TextEditingController();
  final List<Pill> _searchResult = [];

  onSearchSubmitted(String text) async {
    getPillDetails();
  }

  Future<void> getPillDetails() async {
    final String url =
        'https://bula.vercel.app/pesquisar?nome=${controller.text}';
    final response = await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);

    for (Map user in responseJson['content']) {
      _searchResult.add(Pill.fromJson(user));
    }
    setState(() {});
  }

  Future<void> _addPill(Pill p) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pillsString = prefs.getString('myPillsKey');
    if (pillsString == null) {
      pillsString = Pill.encode([p]);
      prefs.setString('myPillsKey', pillsString);
      setState(() {});
      return;
    } else {
      final List<Pill> pills = Pill.decode(pillsString);

      if (!pills.any((element) => element.id == p.id)) {
        pills.add(p);
        pillsString = Pill.encode(pills);
        prefs.setString('myPillsKey', pillsString);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.search),
              title: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onSubmitted: onSearchSubmitted,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  controller.clear();
                  setState(() {
                    _searchResult.clear();
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: _searchResult.isNotEmpty
              ? ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(_searchResult[i].name),
                        subtitle: Text(_searchResult[i].brand),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            _addPill(_searchResult[i]);
                          },
                        ),
                      ),
                    );
                  },
                )
              : const Center(),
        ),
      ],
    );
  }
}
