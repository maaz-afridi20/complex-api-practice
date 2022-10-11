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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
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
                        newList.length,
                        (index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Name'),
                                      Text('${snapshot.data![index]!.name}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Email'),
                                      Text('${snapshot.data![index]!.email}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('City '),
                                      Text(
                                          '${snapshot.data![index]!.address!.city}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Company Name'),
                                      Text(
                                          '${snapshot.data![index]!.company!.name}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
