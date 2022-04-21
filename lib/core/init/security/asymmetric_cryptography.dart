

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'dart:io';
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class Encrypt {
  RSAPrivateKey? _private_key;
  RSAPublicKey? _public_key;
  late final Encrypter encrypter;

  Future<String> _fetchPublicKey() async {

    final publicKey = await rootBundle.loadString('keys/mypublickey.pem');

    return publicKey;
  }
  Future<String> _fetchPrivateKey() async {
    final privateKey = await rootBundle.loadString('keys/myprivatekey.pem');

    return privateKey;
  }

  Future _getPrivateKey() async {
    this._private_key = RSAKeyParser().parse(await _fetchPrivateKey()) as RSAPrivateKey;
    return _private_key;
  }

  Future _getPublicKey() async {
    this._public_key = RSAKeyParser().parse(await _fetchPublicKey()) as RSAPublicKey;
    return _public_key;
  }

  Future<Encrypted> textEncryptor(String textToEncode) async {
    await _getPrivateKey();
    await _getPublicKey();

    encrypter =
    Encrypter(RSA(publicKey: this._public_key,
        privateKey: this._private_key));

    final encrypted = encrypter.encrypt(textToEncode);

    //print(encrypted.base64);
    return encrypted;
  }

  String textDecryptor(Encrypted encrypted){
    final decrypted = encrypter.decrypt(encrypted);
    //print(decrypted);
    return decrypted;
  }
}