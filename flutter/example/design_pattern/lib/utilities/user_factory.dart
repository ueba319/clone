import 'package:design_pattern/models/user.dart';

class UserFactory {
  static User createUser(String name) {
    return User(name: name, isAdmin: false);
  }

  static User createAdmin(String name) {
    return User(name: name, isAdmin: true);
  }
}
