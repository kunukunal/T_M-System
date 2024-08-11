class Property {
  final int id;
  final String title;
  final List<Building> buildings;

  Property({required this.id, required this.title, required this.buildings});

  factory Property.fromJson(Map<String, dynamic> json) {
    var buildingsFromJson = json['buildings'] as List?;
    List<Building> buildingsList =
        buildingsFromJson?.map((i) => Building.fromJson(i)).toList() ?? [];
    return Property(
      id: json['id'],
      title: json['title'],
      buildings: buildingsList,
    );
  }

  @override
  String toString() {
    return title; // Display the title in the dropdown
  }
}

class Building {
  final int id;
  final String name;

  Building({
    required this.id,
    required this.name,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return name; // This will display the name in the dropdown or list
  }
}
