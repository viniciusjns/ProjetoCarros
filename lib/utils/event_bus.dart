import 'dart:async';

import 'package:provider/provider.dart';

class EventBus {
  final _stremController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _stremController.stream;

  sendEvent(Event event) {
    _stremController.add(event);
  }

  dispose() {
    _stremController.close();
  }

  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);
}

class Event {

}