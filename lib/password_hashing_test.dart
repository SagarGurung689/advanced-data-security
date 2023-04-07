import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Password hashing', () {
    test('Hashed password should not be empty', () {
      final password = 'my_password';
      final hashedPassword = hashPassword(password);
      expect(hashedPassword.isNotEmpty, true);
    });

    test('Hashed password should be consistent for same input', () {
      final password = 'my_password';
      final hashedPassword1 = hashPassword(password);
      final hashedPassword2 = hashPassword(password);
      expect(hashedPassword1, hashedPassword2);
    });
  });
}

String hashPassword(String password) {
    var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}
