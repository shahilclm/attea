import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String employeeId;
  final String date; 
  final Timestamp? checkInTime;
  final Timestamp? checkOutTime;
  final bool isLate;
  final double workingHours;

  Attendance({
    required this.employeeId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    this.isLate = false,
    this.workingHours = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'date': date,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'isLate': isLate,
      'workingHours': workingHours,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      employeeId: map['employeeId'],
      date: map['date'],
      checkInTime: map['checkInTime'],
      checkOutTime: map['checkOutTime'],
      isLate: map['isLate'] ?? false,
      workingHours: map['workingHours']?.toDouble() ?? 0.0,
    );
  }
}
