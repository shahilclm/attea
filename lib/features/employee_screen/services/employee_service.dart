import 'dart:io';
import 'package:attea/exporter/exporter.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;

class EmployeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<File> compressImage(File imageFile) async {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;

    final resizedImage = img.copyResize(image, width: 600);

    final compressedFile = File(
      '${imageFile.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
    )..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 70));

    return compressedFile;
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      File compressedImage = await compressImage(imageFile);
      logSuccess("Image compressed successfully");

      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
        'employee_images/${DateTime.now().millisecondsSinceEpoch}.png',
      );

      final uploadTask = imageRef.putFile(compressedImage);

      uploadTask.snapshotEvents.listen((taskSnapshot) {
        double progress =
            (taskSnapshot.bytesTransferred.toDouble() /
                taskSnapshot.totalBytes.toDouble()) *
            100;
        logSuccess("Upload is ${progress.toStringAsFixed(2)}% complete.");
      });

      await uploadTask;

      final downloadUrl = await imageRef.getDownloadURL();
      logSuccess("Image uploaded successfully!");
      logSuccess("Image Download URL: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      logError("Error uploading image: $e");
      return '';
    }
  }

  Future<void> saveEmployeeData(Employee employee) async {
    try {
      final employeeData = employee.toMap();

      await _firestore.collection('employees').doc(employee.employeeId).set({
        ...employeeData,
        'timestamp': FieldValue.serverTimestamp(),
      });

      logSuccess("Employee data saved successfully!");
    } catch (e) {
      logError('Error saving employee data: $e');
    }
  }

  Future<Employee?> getEmployeeById(String employeeId) async {
    try {
      final docSnapshot = await _firestore
          .collection('employees')
          .doc(employeeId)
          .get();
      if (docSnapshot.exists) {
        return Employee.fromMap(docSnapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      logError('Error fetching employee data: $e');
      return null;
    }
  }

  Stream<List<Employee>> getEmployees({String searchQuery = ''}) {
    Query query = _firestore.collection('employees');

    if (searchQuery.isNotEmpty) {
      query = query
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Employee.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
