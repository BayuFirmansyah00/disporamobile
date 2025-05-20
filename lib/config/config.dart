class Config {
  // Base URL - Diubah ke production
  static const String baseApiUrl = 'https://api-ekrafnganjuk.pbltifnganjuk.com/api';
  static const String baseStorageUrl = 'https://api-ekrafnganjuk.pbltifnganjuk.com/storage';
  static const String googleClientId = '668121089918-iq62cn0hns36jjk010ni2tq31eekljo7.apps.googleusercontent.com';
  
  // Authentication - Pastikan token ini valid untuk production
  static const String authToken = 'Bearer <9|ZbV9U21YOfpPILvUTz0zDNg6F6VIIzoegmwhm7Ht857f4525>';
  
  // Endpoints (tidak perlu diubah)
  static const String sectorsEndpoint = 'sectors';
  static const String eventsEndpoint = 'events';
  static const String articlesEndpoint = 'articles';

  static const bool isDebug = false; // Sudah diubah ke false untuk production

  static const String visitorChatThreadsEndpoint = 'visitor/threads';
  static const String visitorChatsEndpoint = 'visitor/chats';
  static const String entrepreneurChatsEndpoint = 'entrepreneur/chats';

  static const int requestTimeout = 30;
}