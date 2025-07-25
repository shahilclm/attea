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
  final Timestamp? timestamp; // Added timestamp field to track creation time

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
    this.timestamp, // Include timestamp in constructor
  });

  // Convert Employee object to a Map for Firestore storage
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
      'timestamp': timestamp, // Include timestamp field in the map
    };
  }

  // Create an Employee object from Firestore data
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
      timestamp: map['timestamp'], // Parse the timestamp from Firestore
    );
  }
}
