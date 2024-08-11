class Property {
  final int id;
  final String title;

  Property({required this.id, required this.title});

  @override
  String toString() {
    return title; // This will be used to display the title in the dropdown
  }
}
