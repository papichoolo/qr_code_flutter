 import 'dart:convert';
 import 'package:http/http.dart' as http;
 import 'secrets.dart';
 

Future<void> updateAttendance(String scannedCode) async {
  /*final db = Db(mongo);
  await db.open();

  final collection = db.collection('TESTING');

  // Use the scannedCode instead of the fixed registration number
  final registrationNumber = scannedCode;

  // Check if the student with the given registration number exists
  final existingStudent = await collection.findOne(where.eq('registration_number', registrationNumber));

  if (existingStudent != null) {
    // Student found in the database, update "presentOrAbsent" to "Absent"
    final result = await collection.update(
      where.eq('registration_number', registrationNumber),
      modify.set('attendance', true),
    );

    if (result['updatedExisting']) {
      print('Attendance marked as Absent for student with registration number $registrationNumber.');
    } else {
      print('Failed to update student attendance.');
    }
  } else {
    print('Student not found in the database.');
  }

  await db.close();*/
  const String awsEnd = awsEndpoint;
  final String requestBodyJson = '{"regno": "$scannedCode"}'; // Replace with your desired JSON request body

  final response = await http.patch(
    Uri.parse(awsEnd),
    headers: {
      'Content-Type': 'application/json',
      // Add any other necessary headers here
    },
    body: requestBodyJson,
  );

  if (response.statusCode == 200) {
    // Successful PATCH request
    final responseBody = json.decode(response.body);
    print('PATCH request successful. Response: $responseBody');
  } else {
    // Error in PATCH request
    print('PATCH request failed with status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

/*import 'package:http/http.dart' as http;
import 'dart:convert';
import 'qr_code_scanner.dart';

void main() async {
  final String requestBodyJson = '{regNo: ""}'; // Replace with your desired JSON request body

  final response = await http.patch(
    Uri.parse(awsEndpoint),
    headers: {
      'Content-Type': 'application/json',
      // Add any other necessary headers here
    },
    body: requestBodyJson,
  );

  if (response.statusCode == 200) {
    // Successful PATCH request
    final responseBody = json.decode(response.body);
    print('PATCH request successful. Response: $responseBody');
  } else {
    // Error in PATCH request
    print('PATCH request failed with status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
*/