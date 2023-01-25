import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/services/service_events.dart';

class UserWasLoggedIn {
  final String name;
  UserWasLoggedIn(this.name);
}

class UserWasLoggedOut {}

class UserWasCreated {}

Future<void> main() async {
  test('Test events', () {
    ServiceEvents events = ServiceEvents();

    String data = "no";
    String data1 = "no";
    String data2 = "no";

    //first listener
    events.listen<UserWasLoggedOut>((e) => data = 'yes');

    //second listener
    events.listen<UserWasLoggedOut>((e) => data1 = 'yes');

    //third listener
    events.listen<UserWasLoggedIn>((e) => data2 = e.name);

    expect(data, 'no');
    expect(data1, 'no');
    expect(data2, 'no');

    events.fire(UserWasLoggedOut());

    expect(data, 'yes');
    expect(data1, 'yes');

    events.fire(UserWasLoggedIn('wow'));
    expect(data2, 'wow');

    events.fire(UserWasCreated());
  });
}
