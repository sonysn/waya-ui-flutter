import 'package:flutter/material.dart';
import '../../../colorscheme.dart';
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
          backgroundColor: customPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Last updated: [01-06-2023]',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '1. Information We Collect',
              content: [
                '1.1 Personal Information: When you use our App and Services, we may collect certain personal information, including but not limited to:',
                '- Your name',
                '- Contact information (e.g., email address, phone number)',
                '- Payment information',
                '- Profile information (e.g., profile picture, user preferences)',
                '- Geolocation data',
                '- Communications and interactions with other users',
                '',
                '1.2 Usage Information: We may automatically collect certain usage information when you use our App, such as:',
                '- Device information (e.g., device type, operating system)',
                '- Log information (e.g., IP address, browser type)',
                '- App usage data (e.g., features accessed, time spent on the App)',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '2. How We Use Your Information',
              content: [
                'We may use the collected information for the following purposes:',
                '- To provide and maintain our Services',
                '- To process your transactions and payments',
                '- To personalize your experience and improve our App',
                '- To communicate with you and respond to your inquiries',
                '- To enforce our terms and policies',
                '- To prevent fraud and enhance the security of our App',
                '- To analyze usage trends and perform data analytics',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '3. How We Share Your Information',
              content: [
                'We may share your personal information in the following circumstances:',
                '- With drivers and riders involved in your trip for the purpose of providing the requested services',
                '- With third-party service providers who assist us in delivering our Services',
                '- With law enforcement agencies or government authorities as required by applicable laws',
                '- In connection with a merger, acquisition, or sale of all or a portion of our business',
                '- With your consent or as otherwise disclosed at the time of data collection',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '4. Data Retention',
              content: [
                'We will retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '5. Your Choices and Rights',
              content: [
                'You have certain choices and rights regarding the collection and use of your personal information. These may include the ability to access, update, or delete your information, and to opt-out of certain data processing activities. Please contact us using the information provided below to exercise your rights.',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '6. Security',
              content: [
                'We take reasonable measures to protect the security of your personal information. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security.',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: "7. Children's Privacy",
              content: [
                'Our App and Services are not intended for children under the age of 13. We do not knowingly collect personal information from children under the age of 13. If we become aware that we have collected personal information from a child under the age of 13, we will take steps to delete it.',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '8. Updates to this Privacy Policy',
              content: [
                'We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the updated Privacy Policy on our App or by other means of communication. Your continued use of our App after the effective date of the updated Privacy Policy constitutes your acceptance of the changes.',
              ],
            ),
            SizedBox(height: 16.0),
            PrivacyPolicySection(
              title: '9. Contact Us',
              content: [
                'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  final String title;
  final List<String> content;

  PrivacyPolicySection({
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
            color: customPurple, // Custom purple color
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content.map((item) => Text(item)).toList(),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}


