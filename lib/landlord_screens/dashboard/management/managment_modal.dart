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
  final List<Floor> floors;

  Building({required this.id, required this.name, required this.floors});

  factory Building.fromJson(Map<String, dynamic> json) {
    var floorsFromJson = json['floors'] as List?;
    List<Floor> floorsList =
        floorsFromJson?.map((i) => Floor.fromJson(i)).toList() ?? [];
    return Building(
      id: json['id'],
      name: json['name'],
      floors: floorsList,
    );
  }

  @override
  String toString() {
    return name; // This will display the name in the dropdown or list
  }
}

class Floor {
  final int id;
  final String name;
  final List<Unit> units;

  Floor({required this.id, required this.name, required this.units});

  factory Floor.fromJson(Map<String, dynamic> json) {
    var unitsFromJson = json['units'] as List?;
    List<Unit> unitsList =
        unitsFromJson?.map((i) => Unit.fromJson(i)).toList() ?? [];
    return Floor(
      id: json['id'],
      name: json['name'],
      units: unitsList,
    );
  }

  @override
  String toString() {
    return name; // Display the floor name in the dropdown
  }
}

class Unit {
  final int id;
  final String name;
  final double unitRent;
  final bool isRentRnegotiable;
  final List<Amenity> amenities;

  Unit(
      {required this.id,
      required this.name,
      required this.unitRent,
      required this.isRentRnegotiable,
      required this.amenities});

  factory Unit.fromJson(Map<String, dynamic> json) {
    var amenitiesFromJson = json['amenities'] as List?;
    List<Amenity> amenitiesList =
        amenitiesFromJson?.map((i) => Amenity.fromJson(i)).toList() ?? [];
    return Unit(
      id: json['id'],
      name: json['name'],
      isRentRnegotiable: json['is_rent_negotiable'],
      unitRent: (json['unit_rent'] ?? 0).toDouble(),
      amenities: amenitiesList,
    );
  }

  @override
  String toString() {
    return name; // Display the unit name in the dropdown
  }
}

class Amenity {
  final int id;
  final String name;
  final String price;

  Amenity({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'],
      name: json['name'],
      price: (json['price'] ?? "0"), // Handle null value with a default
    );
  }

  @override
  String toString() {
    return name; // This will display the name in the dropdown or list
  }
}
