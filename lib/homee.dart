import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice8/model.dart';

class Homee extends StatefulWidget {
  Homee({Key? key}) : super(key: key);

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  List<Userss?> newList = [];

  Future<List<Userss?>> fetchData() async {
    String urll = "https://jsonplaceholder.typicode.com/users";
    http.Response response = await http.get(Uri.parse(urll));

    var jesonDecoded = await json.decode(response.body);

    if (response.statusCode == 200) {
      for (var i in jesonDecoded) {
        newList.add(Userss.fromJson(i));
      }
      return newList;
    } else {
      return newList;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot<List<Userss?>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  ...List.generate(
                    1,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    child: const Card(
                                      child: Center(
                                        child: Text('Name :'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    child: Card(
                                      child: Center(
                                        child: Text(
                                            '${snapshot.data![index]!.name}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    child: const Card(
                                      child: Center(
                                        child: Text('Email Address :'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    child: Card(
                                      child: Center(
                                        child: Text(
                                            '${snapshot.data![index]!.email}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    child: const Card(
                                      child: Center(
                                        child: Text('Address :'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    child: Card(
                                      child: Center(
                                        child: Text(
                                            '${snapshot.data![index]!.address!.city} ' +
                                                '${snapshot.data![index]!.address!.street}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    child: const Card(
                                      child: Center(
                                        child: Text('Company Name :'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    child: Card(
                                      child: Center(
                                        child: Text(
                                            '${snapshot.data![index]!.company!.name}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
