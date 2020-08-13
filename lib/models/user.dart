import '../string_util.dart';

enum LoginType { email, phone }

class User with UserUtils {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email,
        _type = email != null ? LoginType.email : LoginType.phone {
    print('User $firstName $lastName is created');
  }

  factory User({String name, String phone, String email}) {
    if (name?.isEmpty == true) throw Exception("User name is empty");
    if (phone?.isEmpty == true || email?.isEmpty == true)
      throw Exception("Phone or email is empty");
    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: phone != null ? checkPhone(phone) : '',
      email: email != null ? checkEmail(email) : ''
    );
  }

  static String _getFirstName(String name) => name.split(" ")[0];

  static String _getLastName(String name) => name.split(" ")[1];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp(r"[^+\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Phone number cannot be empty.");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Phone number is not valid (should be started with + and contain 11 digits).");
    }
    return phone;
  }

//  static String checkEmail(String email) {
//    if (email == null || email.isEmpty) {
//      throw Exception("Email cannot be empty.");
//    }
//    return email;
//  }

  static String checkEmail(String email) =>
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
              .hasMatch(email)
          ? email
          : throw Exception('Invalid email');

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${_firstName.capitalize()} ${_lastName.capitalize()}";

  @override
  bool operator ==(Object user2) {
    if (user2 == null) return false;
    return user2 is User &&
        user2._lastName == _lastName &&
        user2._firstName == _firstName &&
        user2._type == _type &&
        (user2.email == email || user2.phone == phone);
  }

  @override
  int get hashCode => super.hashCode;

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()}
  ''';
  }
}

mixin UserUtils {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}