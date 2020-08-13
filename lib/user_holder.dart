//import 'package:test_flutter/models/user.dart';

import 'package:FlutterGalleryApp/models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  init() {
    User user =
        User(name: "Name", email: "test@mail.ru", phone: "+79172683644");
  }

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    print(user);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
    } else {
      throw Exception("User with this credentials already exists.");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
      return user;
    } else {
      throw Exception("A user with this email already exists");
    }
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
      return user;
    } else {
      throw Exception("A user with this phone already exists");
    }
  }

  User getUserByLogin(String login) => users[login];

  User findUserInFriends(String login, User friend) =>
      users[login].friends.contains(friend)
          ? friend
          : throw Exception('$login is not a friend of the login');

  void setFriends(String userLogin, List<User> friends) {
    if (users[userLogin] != null) {
      users[userLogin].friends = friends;
    }
  }

  List<User> importUsers(List<String> usersString) { // [Dan Epel;mail.com;phone;]
    List<User> users = [];
    usersString.forEach((element) {
      List<String> splittedUser = splitString(element);
      User user = User(name: splittedUser[0].trim(), email: splittedUser[1].trim(), phone: splittedUser[2].trim());
      users.add(user);
    });
    return users;
  }

  List<String> splitString(String str) {
    return str.split(';');
  }
}
