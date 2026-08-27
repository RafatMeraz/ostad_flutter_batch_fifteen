class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signup';

  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';

  static const String signInUrl = '$_baseUrl/auth/login';

  static const String homeSlidersUrl = '$_baseUrl/slides';

  static String getCategoryListUrl(int pageNo, int pageSize) =>
      '$_baseUrl/categories?page=$pageNo&count=$pageSize';

  static String getProductListByCategoryUrl(
          String categoryId, int pageNo, int pageSize) =>
      '$_baseUrl/products?category=$categoryId&page=$pageNo&count=$pageSize';

  static String getProductDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';
}
