class ApiConstants {
  static String baseUrl = 'http://192.168.100.43:3000';
  static const port = 3000;
  static String signInEndpoint = '/signin';
  static String signUpEndpoint = '/signup';
  static String requestRideEndpoint = '/requestride';
  static String getRidePrice = '/getRidePrice';
  static String getRidesHistory = '/:userId/getridehistory';
  static String getBalanceEndpoint = '/getbalance';
  static String logoutEndpoint = '/logoutuser';
  static String chargeEndpoint = '/charge';
  static String driverCountEndpoint = '/driverCount';
}