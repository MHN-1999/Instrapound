import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' as meterial;
import 'package:instrapound/_common/c_datacontroller.dart';

class EncryptService {
  // static final _iv = IV.fromLength(16); // Adjusted to 16 for AES block size
  static final _iv = IV.fromUtf8("abcdefghijklmnop");
  static final _secretKey = Key.fromUtf8("aklr92YH25FFls92kg765TFGHsew41ol");

  // Test function to demonstrate encryption and decryption
  test() {
    const plainText = 'ViCiu123@';

    final encryptor = Encrypter(AES(_secretKey));

    final encrypted = encryptor.encrypt(plainText, iv: _iv);
    final decrypted = encryptor.decrypt(encrypted, iv: _iv);

    print("encrypted - " + encrypted.base64);
    print("decrypted - " + decrypted);
  }

  // Method to decrypt text
  String? decryptText({required String encryptedText}) {
    String? result;
    try {
      final encryptor = Encrypter(AES(_secretKey));
      final encrypted = Encrypted.fromBase64(encryptedText);
      result = encryptor.decrypt(encrypted, iv: _iv);
    } catch (e) {
      print("Decryption error: $e");
      mySuccessDialog("Decryption error: $e", false, meterial.Colors.red);
    }
    return result;
  }

  // Method to encrypt text
  String? encryptText({required String plainText}) {
    String? result;
    try {
      final encryptor = Encrypter(AES(_secretKey));
      final encrypted = encryptor.encrypt(plainText, iv: _iv);
      result = encrypted.base64;
    } catch (e) {
      print("Encryption error: $e");
      mySuccessDialog("Encryption error: $e", false, meterial.Colors.red);
    }
    return result;
  }
}
