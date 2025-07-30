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
  final String? hrId;
  final bool isActive;
  final String? firebaseUid;

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
    this.hrId,
    this.isActive = true,
    this.firebaseUid,
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
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
      'hrId': hrId,
      'isActive': isActive,
      'firebaseUid': firebaseUid,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeId: map['employeeId'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      whatsappNumber: map['whatsappNumber'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      category: map['category'] ?? '',
      dob: DateTime.parse(map['dob']),
      timestamp: map['timestamp'],
      hrId: map['hrId'],
      isActive: map['isActive'] ?? true,
      firebaseUid: map['firebaseUid'],
    );
  }

  factory Employee.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Employee.fromMap(data);
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
    String? hrId,
    bool? isActive,
    String? firebaseUid,
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
      hrId: hrId ?? this.hrId,
      isActive: isActive ?? this.isActive,
      firebaseUid: firebaseUid ?? this.firebaseUid,
    );
  }
}

// class Employee {
//   final String employeeId;
//   final String name;
//   final String phoneNumber;
//   final String whatsappNumber;
//   final String role;
//   final String email;
//   final String photoUrl;
//   final String category;
//   final DateTime dob;
//   final Timestamp? timestamp;

//   Employee({
//     required this.employeeId,
//     required this.name,
//     required this.phoneNumber,
//     required this.whatsappNumber,
//     required this.role,
//     required this.email,
//     required this.photoUrl,
//     required this.category,
//     required this.dob,
//     this.timestamp,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'employeeId': employeeId,
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'whatsappNumber': whatsappNumber,
//       'role': role,
//       'email': email,
//       'photoUrl': photoUrl,
//       'category': category,
//       'dob': dob.toIso8601String(),
//       'timestamp': timestamp,
//     };
//   }

//   factory Employee.fromMap(Map<String, dynamic> map) {
//     return Employee(
//       employeeId: map['employeeId'],
//       name: map['name'],
//       phoneNumber: map['phoneNumber'],
//       whatsappNumber: map['whatsappNumber'],
//       role: map['role'],
//       email: map['email'],
//       photoUrl: map['photoUrl'],
//       category: map['category'],
//       dob: DateTime.parse(map['dob']),
//       timestamp: map['timestamp'],
//     );
//   }
//   static List<String> get availableCategories {
//     return [
//       'Flutter',
//       'Backend',
//       'Web',
//       'Digital Marketing',
//       'Interns',
//       'Testers',
//     ];
//   }
//   ///

//   // Add copyWith method
//   Employee copyWith({
//     String? employeeId,
//     String? name,
//     String? phoneNumber,
//     String? whatsappNumber,
//     String? role,
//     String? email,
//     String? photoUrl,
//     String? category,
//     DateTime? dob,
//     Timestamp? timestamp,
//   }) {
//     return Employee(
//       employeeId: employeeId ?? this.employeeId,
//       name: name ?? this.name,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       whatsappNumber: whatsappNumber ?? this.whatsappNumber,
//       role: role ?? this.role,
//       email: email ?? this.email,
//       photoUrl: photoUrl ?? this.photoUrl,
//       category: category ?? this.category,
//       dob: dob ?? this.dob,
//       timestamp: timestamp ?? this.timestamp,
//     );
//   }
// }
