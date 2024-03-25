import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String eventName;
  final String eventDesc;
  final String eventType;
  final String eventMode;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final bool eventPublished;

  Event({
    required this.eventName,
    required this.eventDesc,
    required this.eventType,
    required this.eventMode,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.eventPublished,
  });
}

class DbService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  getEvents() async {
    return await db.collection('users').get();
  }

  getEventsFromUid(String uid) async{
    return await db.collection('users').get().then((value) => value.docs);
  }



  Event? eventFromFirestoreEvent(snapshot) {
    return snapshot != null
        ? Event(
            eventName: snapshot.id,
            eventDesc: snapshot['eventDesc'],
            eventType: snapshot['eventType'],
            eventMode: snapshot['eventMode'],
            startDate: snapshot['startDate'],
            endDate: snapshot['endDate'],
            startTime: snapshot['startTime'],
            endTime: snapshot['endTime'],
            eventPublished: snapshot['eventPublished'],
          )
        : null;
  }
}
