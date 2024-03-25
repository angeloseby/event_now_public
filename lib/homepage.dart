import 'package:flutter/material.dart';
import 'package:event_now_public/helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    final dbService = DbService();
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: const Color.fromRGBO(75, 22, 128, 1.0),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_white.png',
          width: screenWidth * 0.120,
        ),
      ),
      body: FutureBuilder(
        future: dbService.getEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final eventSnapshotData = snapshot.data;
            List events = [];
            print(eventSnapshotData.docs[0].data()['event']);

            // eventSnapshotData.forEach((eventData)  {
            //   final uid = eventData.id;
            //   print(uid);
            // });
            // eventSnapshotData.forEach((data) {
            //   events.add(dbService.eventFromFirestoreEvent(data));
            // });
            //print(events[0].eventName);
            if (events.isNotEmpty) {
              return Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //TODO: change this 3
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            // child: EventTile(
                            //   event: events[index],
                            // ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "No Events",
                ),
              );
            }
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Some Error Occured",
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
