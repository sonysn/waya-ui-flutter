import 'package:flutter/material.dart';
import '../../../colorscheme.dart';
class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text(
  'Help Center',
  style: TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  backgroundColor: Colors.black, // Custom app bar color
  ),
  body: SingleChildScrollView(
  padding: EdgeInsets.all(16.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  HelpCenterSection(
  title: 'Getting Started',
  content: [
  HelpCenterItem(
  title: 'How to create an account',
  description: "To create an account on Qunot, follow these steps:\n\n1. Download and install the Qunot app from the App Store or Google Play Store.\n2. Open the app and tap on the 'Sign Up' button.\n3. Enter your personal details, such as your name, email address, and phone number.\n4. Set a password for your account.\n5. Agree to the Terms of Service and Privacy Policy.\n6. Tap on 'Sign Up' to create your Qunot account.\n\nOnce you've completed these steps, you can start using Qunot to book rides.",
  ),
  HelpCenterItem(
  title: 'Booking your first ride',
  description: "To book your first ride on Qunot, follow these steps:\n\n1. Open the Qunot app and sign in to your account.\n2. Enter your pickup location in the 'From' field.\n3. Enter your destination in the 'To' field.\n4. Request a ride. \n5. Review the estimated fare and tap on the 'Confirm' button.\n6. Qunot will match you with a nearby driver, and you'll see the driver's details, including their photo, and vehicle information.\n7.Meet the driver to arrive at your pickup location.\n8. Enjoy your ride with Qunot!\n\nAfter your ride, you'll have the option to rate your driver and provide feedback.",
  ),
  ],
  ),
  SizedBox(height: 16.0),
  HelpCenterSection(
  title: 'Account and Profile',
  content: [
  HelpCenterItem(
  title: 'Updating your profile information',
  description: 'To update your profile information on Qunot, follow these steps:\n\n1. Open the Qunot app and sign in to your account.\n2. Tap on the profile icon left corner of the screen.\n3. Select "Profile" from the menu.\n4. Tap on the "Edit" button next to the information you want to update, such as your name, email address, or phone number.\n5. Make the necessary changes and tap on the "Update" button.\n\nYour profile information will be updated accordingly.',
  ),
  HelpCenterItem(
  title: 'Resetting your password',
  description: "To reset your password on Qunot, follow these steps:\n\n1. Open the Qunot app and tap on the 'Sign In' button.\n2. On the sign-in screen, tap on the 'Forgot Password?' link.\n3. Enter the email address associated with your Qunot account.\n4. Qunot will send you an email with instructions on how to reset your password.\n5. Follow the instructions in the email to reset your password.\n\nOnce you've reset your password, you can sign in to your Qunot account using your new password.",
  ),
  ],
  ),
  SizedBox(height: 16.0),
  HelpCenterSection(
  title: 'Payments and Refunds',
  content: [

  HelpCenterItem(
  title: 'Requesting a refund',
  description: "If you believe you're eligible for a refund on Qunot, please follow these steps:\n\n1. Open the Qunot app and sign in to your account.\n2. Tap on the profile icon on left corner of the screen.\n3. Select 'Help' from the menu.\n4. Choose the option to contact our support team.\n5. Provide detailed information about your refund request, including the ride details and the reason for the refund.\n\nOur support team will review your request and get back to you as soon as possible.",
  ),
  ],
  ),
  ],
  ),
  ),
  );
  }
  }

  class HelpCenterSection extends StatelessWidget {
  final String title;
  final List<HelpCenterItem> content;

  HelpCenterSection({
  required this.title,
  required this.content,
  });

  @override
  Widget build(BuildContext context) {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  title,
  style: TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(height: 8.0),
  Column(
  children: content.map((item) {
  return Padding(
  padding: EdgeInsets.only(bottom: 16.0),
  child: HelpCenterItemWidget(item: item),
  );
  }).toList(),
  ),
  ],
  );
  }
  }

  class HelpCenterItem {
  final String title;
  final String description;

  HelpCenterItem({
  required this.title,
  required this.description,
  });
  }

  class HelpCenterItemWidget extends StatelessWidget {
  final HelpCenterItem item;

  HelpCenterItemWidget({
  required this.item,
  });

  @override
  Widget build(BuildContext context) {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  item.title,
  style: TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(height: 8.0),
  Text(item.description),
  ],
  );
  }
  }

