import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DriverList extends StatefulWidget {
  const DriverList({super.key});

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  CollectionReference driver = FirebaseFirestore.instance.collection('driver_info');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 244, 244),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Driver\'s Information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 239, 255),
      ),
      body: RawScrollbar(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
          child: StreamBuilder(
            stream: driver.snapshots(),
            builder: ((context, snapshot) {
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => Column(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Driver ${index + 1}s Info',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Name : ${snapshot.data!.docs[index]['name']}",
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Phone no. : ${snapshot.data!.docs[index]['number']}", style: const TextStyle(fontSize: 17)),
                                          IconButton(
                                              onPressed: () => launchUrlString("tel://${snapshot.data!.docs[index]['number']}"),
                                              icon: const Icon(
                                                Icons.call,
                                                size: 17,
                                              ))
                                        ],
                                      ),
                                      Text(
                                        "Alloted Bus No. : ${snapshot.data!.docs[index]['alloted_bus_number']}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )));
            }),
          ),
        ),
      ),
    );
  }
}
