abstract class EnvConfig {
  String get baseApiUrl;
  String get baseStorageUrl;
  String get authToken;
}

class DevConfig implements EnvConfig {
  @override String get baseApiUrl => 'http://10.0.2.2:8000/api';
  @override String get baseStorageUrl => 'http://10.0.2.2:8000/storage';
  @override String get authToken => 'Bearer <9|ZbV9U21YOfpPILvUTz0zDNg6F6VIIzoegmwhm7Ht857f4525>';
}

class ProdConfig implements EnvConfig {
  @override String get baseApiUrl => 'https://api-ekrafnganjuk.pbltifnganjuk.com/api';
  @override String get baseStorageUrl => 'https://api-ekrafnganjuk.pbltifnganjuk.com/storage';
  @override String get authToken => 'Bearer <9|ZbV9U21YOfpPILvUTz0zDNg6F6VIIzoegmwhm7Ht857f4525>';
}