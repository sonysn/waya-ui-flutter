/// A class representing user data.
class Data {
  /// The authentication token for the user.
  final String authToken;

  /// The ID of the user.
  final int id;

  /// The first name of the user.
  final String firstName;

  /// The last name of the user.
  final String lastName;

  /// The phone number of the user.
  final String phoneNumber;

  /// The email address of the user.
  final String email;

  /// The address of the user.
  final String address;

  /// The URL of the user's profile photo.
  final String? profilePhoto;

  /// The user's rating.
  final double rating;

  /// The user's account balance.
  final double accountBalance;

  /// Creates a new instance of the [Data] class.
  Data(
      {required this.authToken,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      required this.address,
      required this.profilePhoto,
      required this.rating,
      required this.accountBalance});

  /// Creates a new instance of the [Data] class from a JSON map.
  ///
  /// The [json] parameter should contain the following keys:
  ///
  /// - `token`: A string representing the authentication token.
  /// - `result`: A list containing a single map with the following keys:
  ///   - `ID`: An integer representing the user ID.
  ///   - `FIRST_NAME`: A string representing the user's first name.
  ///   - `LAST_NAME`: A string representing the user's last name.
  ///   - `PHONE_NUMBER`: A string representing the user's phone number.
  ///   - `EMAIL`: A string representing the user's email address.
  ///   - `ADDRESS`: A string representing the user's address.
  ///   - `PROFILE_PHOTO`: A string representing the URL of the user's profile photo.
  ///   - `RATING`: A number representing the user's rating.
  ///   - `ACCOUNT_BALANCE`: A number representing the user's account balance.
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      authToken: json['token'],
      id: json['result'][0]['ID'],
      firstName: json['result'][0]['FIRST_NAME'],
      lastName: json['result'][0]['LAST_NAME'],
      phoneNumber: json['result'][0]['PHONE_NUMBER'],
      email: json['result'][0]['EMAIL'],
      address: json['result'][0]['ADDRESS'],
      profilePhoto: json['result'][0]['PROFILE_PHOTO'],
      rating: double.parse(json['result'][0]['RATING'].toString()),
      accountBalance:
          double.parse(json['result'][0]['ACCOUNT_BALANCE'].toString()),
    );
  }
}
