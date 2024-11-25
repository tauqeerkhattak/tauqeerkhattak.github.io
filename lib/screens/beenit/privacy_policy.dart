import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';

class BeenItPrivacyPolicy extends StatelessWidget {
  const BeenItPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.beenitLogo,
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Privacy Policy for BeenIt Messenger',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Last Updated: October 19th, 2024',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              'Introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'BeenIt Messenger ("we", "our", or "us") is dedicated to safeguarding your privacy. '
              'This Privacy Policy describes how we collect, use, and protect the personal '
              'information of users ("you", "your") when you use our mobile application ("App").',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'By using BeenIt Messenger, you agree to the terms of this Privacy Policy. If you do '
              'not agree, please discontinue use of the App.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'a. Personal Information: \n- Contact List: To enable communication, BeenIt Messenger '
              'requires access to your phone\'s contact list. We only use this information to determine '
              'which contacts are available to chat with.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'b. Communication Data: \n- Messages and Files: Messages and files sent between users are '
              'encrypted using AES encryption. We do not access or store the content of messages unless the '
              'user requests a backup or data recovery service.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'c. Usage Data: \n- Basic usage data, such as interactions with the App and error logs, '
              'may be collected to improve user experience. This data is not encrypted.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may use the information we collect for the following purposes:\n'
              '- To provide and maintain the functionality of BeenIt Messenger.\n'
              '- To improve the App based on usage patterns and feedback.\n'
              '- To troubleshoot technical issues or bugs.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '3. Data Encryption and Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '- AES Encryption: Messages and files shared between users are encrypted using AES encryption to '
              'protect sensitive information.\n'
              '- Unencrypted Data: Non-sensitive data, including your contact list and general usage data, is not encrypted.\n'
              'We use commercially reasonable means to protect your personal information, but please note that no method of transmission '
              'or storage is 100% secure.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '4. Account Deletion and Data Retention',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '- Account Deletion: Users have the option to delete their account at any time. Once an account is deleted, '
              'we will retain your data for 15 days. After this period, all associated data, including messages, files, '
              'and personal information, will be permanently deleted from our servers.\n'
              '- Message and File Deletion: Users can delete messages and files at any time. Once deleted, these items will no '
              'longer be available to the sender, recipient, or stored on our servers.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '5. Sharing of Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We do not sell, trade, or otherwise share your personal information with third parties, except in the following situations:\n'
              '- Legal Obligations: If required by law or to protect the rights, property, or safety of BeenIt Messenger, our users, or others.\n'
              '- Service Providers: In certain cases, we may share data with third-party service providers to help us operate the App. These providers will '
              'have limited access and are bound by confidentiality obligations.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '6. Your Privacy Rights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildEmailSpanText(
              context: context,
              text:
                  'Depending on your jurisdiction, you may have the right to access, correct, or delete your personal information. '
                  'You can do this by contacting our support team at ',
            ),
            Divider(height: 20),
            Text(
              '7. Children’s Privacy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'BeenIt Messenger is not intended for use by individuals under the age of 13. We do not knowingly collect personal information '
              'from children. If we become aware that a child under 13 has provided us with personal data, we will take steps to delete such information.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '8. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. Any updates will be posted within the App, '
              'and your continued use of BeenIt Messenger constitutes acceptance of these changes.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildEmailSpanText(
              context: context,
              text:
                  'If you have any questions or concerns about this Privacy Policy, please contact us at ',
            ),
          ],
        ),
      ),
    );
  }

  RichText _buildEmailSpanText({
    required BuildContext context,
    required String text,
  }) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
            ),
        children: [
          TextSpan(
            text: 'tauqeer745@outlook.com',
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await launchUrl(Uri.parse('mailto:tauqeer745@outlook.com'));
              },
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          )
        ],
      ),
    );
  }
}
