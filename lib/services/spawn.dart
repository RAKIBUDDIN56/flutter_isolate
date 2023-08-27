import 'dart:convert';
import 'dart:isolate';

import '../api.dart';

class SpawnService {
  Future<Person?> fetchUser() async {
    ReceivePort port = ReceivePort();
    String userData = await Api.getUser("Spawn");
    final isolate = await Isolate.spawn<List<dynamic>>(
        deserializePerson, [port.sendPort, userData]);
        isolate.kill(priority: Isolate.immediate);  
    return await port.first;
  }

  void deserializePerson(List<dynamic> values) {
    SendPort sendPort = values[0];
    String data = values[1];
    Map<String, dynamic> dataMap = jsonDecode(data);
    sendPort.send(Person(dataMap["name"]));
  }
}
