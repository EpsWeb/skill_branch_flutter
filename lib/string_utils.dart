extension MyString on String {
  String capitalize() =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();

//  String capitalize(String s) => s.capitalized; // WTF
}
