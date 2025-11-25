class PetModel {
  final String? id;
  final String userId;
  final String name;
  final String breed;
  final String age;
  final String foodPhilosophy;
  final List<String> healthIssues;
  final bool hasHealthIssues;
  final bool profileCompleted;

  PetModel({
    this.id,
    required this.userId,
    required this.name,
    required this.breed,
    required this.age,
    required this.foodPhilosophy,
    this.healthIssues = const [],
    this.hasHealthIssues = false,
    this.profileCompleted = false,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['_id'] ?? json['id'],
      userId: json['user'] ?? json['userId'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? '',
      foodPhilosophy: json['foodPhilosophy'] ?? '',
      healthIssues: List<String>.from(json['healthIssues'] ?? []),
      hasHealthIssues: json['hasHealthIssues'] ?? false,
      profileCompleted: json['profileCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'breed': breed,
      'age': age,
      'foodPhilosophy': foodPhilosophy,
      'healthIssues': healthIssues,
      'hasHealthIssues': hasHealthIssues,
      'profileCompleted': profileCompleted,
    };
  }
}

// Age options enum
enum PetAge {
  puppy('Puppy years'),
  adult('Adult'),
  senior('Senior');

  final String value;
  const PetAge(this.value);
}

// Food philosophy enum
enum FoodPhilosophy {
  budget('Budget-friendly & reliable'),
  premium('Premium & Natural'),
  unsure('I\'m not sure, help me choose!');

  final String value;
  const FoodPhilosophy(this.value);
}
