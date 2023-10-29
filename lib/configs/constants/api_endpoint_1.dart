class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:8000/"; //emulator
  // static const String baseUrl = "http://192.168.18.140:3000/"; //home
  // static const String baseUrl = "http://172.21.0.211:3000/";

  // ====================== Auth Routes ======================
  static const String login = "/signin";
  static const String register = "/register";
  static const String uploadImage = "upload/album";
  static const String uploadAudio = "upload/audio";
  static const String uploadPodcast = "podcasts";
  static const String getallpodcast = "podcasts";
  static const String getallpodcastbyid = "podcasts/user/podcasts";
  static const String addFavoritePodcast = "favorite/add/";
  // static const String getFavoritePodcast = "favorite/podcasts";
  static const String updatepodcast = "podcasts/";
  static const String deletepodcast = "podcasts/";
  static const String getFavorite = "favorite/podcast";
  static const String deleteFavorite = "favorite/remove/";
  static const String patchusername = "users/";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String uploadImage = "auth/uploadImage";
}
