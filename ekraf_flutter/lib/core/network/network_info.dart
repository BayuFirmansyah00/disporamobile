import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekraf_kuy/main.dart';

// Interface untuk mengecek koneksi internet
abstract class NetworkInfoI {
  Future<bool> isConnected();

  Future<List<ConnectivityResult>> get connectivityResult;
  
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class NetworkInfo implements NetworkInfoI {
  Connectivity connectivity;

  static final NetworkInfo _networkInfo = NetworkInfo._internal(Connectivity());

  factory NetworkInfo() {
    return _networkInfo;
  }

  NetworkInfo._internal(this.connectivity){
    connectivity = this.connectivity;
  }

  /// Mengecek apakah internet terhubung atau tidak
  /// Mengembalikan [true] jika terhubung, 
  /// jika tidak maka [false]
  @override
  Future<bool> isConnected() async {
    final result = await connectivityResult;
    return !result.contains(ConnectivityResult.none);
  }

  /// Mengecek jenis koneksi internet
  @override
  Future<List<ConnectivityResult>> get connectivityResult async {
    return connectivity.checkConnectivity();
  }

  /// Mengecek jenis koneksi saat ada perubahan jaringan
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}

abstract class Failure {}

// Kelas error umum
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

/// Exception untuk menangani kasus tanpa internet
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'No Internet Exception Occurred']) {
    if (globalMessengerKey.currentState != null) {
      globalMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text(message)));
    }
    this._message=message;
  }

  @override
  String toString() {
    return _message;
  }
}