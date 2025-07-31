import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String employeeId;
  final String name;
  final String phoneNumber;
  final String whatsappNumber;
  final String role;
  final String email;
  final String photoUrl;
  final String category;
  final DateTime dob;
  final Timestamp? timestamp;

  Employee({
    required this.employeeId,
    required this.name,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.role,
    required this.email,
    required this.photoUrl,
    required this.category,
    required this.dob,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'name': name,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'role': role,
      'email': email,
      'photoUrl': photoUrl,
      'category': category,
      'dob': dob.toIso8601String(),
      'timestamp': timestamp,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeId: map['employeeId'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      whatsappNumber: map['whatsappNumber'],
      role: map['role'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      category: map['category'],
      dob: DateTime.parse(map['dob']),
      timestamp: map['timestamp'],
    );
  }
  static List<String> get availableCategories {
    return [
      'Flutter',
      'Backend',
      'Web',
      'Digital Marketing',
      'Interns',
      'Testers',
    ];
  }

  ///

  // Add copyWith method
  Employee copyWith({
    String? employeeId,
    String? name,
    String? phoneNumber,
    String? whatsappNumber,
    String? role,
    String? email,
    String? photoUrl,
    String? category,
    DateTime? dob,
    Timestamp? timestamp,
  }) {
    return Employee(
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      role: role ?? this.role,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      category: category ?? this.category,
      dob: dob ?? this.dob,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
