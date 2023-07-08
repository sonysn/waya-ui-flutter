class ApiConstants {
  // static String baseUrl = 'http://192.168.100.43:3000';
  static String baseUrl = 'https://waya-api.onrender.com';
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
  static String transferToDriversEndpoint = '/transferToDrivers';
  static String transferToUsersEndpoint = '/transferToUsers';
  static String getRiderPaystackDepositTransactions =
      '/getRiderPaystackDepositTransactions';
  static String getUserToUserTransactions = '/getUserToUserTransactions';
  static String getUserToDriverTransactions = '/getUserToDriverTransactions';
  static String getUserToUserTransactionsForReceiver =
      '/getUserToUserTransactionsForReceiver';
  static String getCurrentRideEndpoint = '/getCurrentRide';
  static String onRiderCancelledRide = '/onRiderCancelledRide';
  static String getRiderTripHistoryEndpoint = '/getRiderTripHistory';
  static String forgotPasswordEndpoint = '/forgotPassword';
  static String changePasswordEndpoint = '/userchangepassword';
  static String verifyForgotPasswordChangeEndpoint =
      '/verifyForgotPasswordChange';
  static String uploadProfileImageEndpoint = '/userUploadProfilePicture';
}
