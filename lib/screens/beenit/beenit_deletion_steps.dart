import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';

class BeenItDeletionSteps extends StatelessWidget {
  const BeenItDeletionSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
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
            'Account and Data Deletion for BeenIt Messenger',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Last Updated: October 19th, 2024',
            style: TextStyle(fontSize: 16),
          ),
          Divider(height: 20),
          Text(
            'Delete your account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Please follow the following steps to delete your account:',
            style: TextStyle(fontSize: 16),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Open BeenIt Messenger on your phone.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '2. Open your account page by tapping the menu icon on Chats page',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '3. There will be a button named Delete your account.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '4. Tapping the button will require you to confirm and authenticate again.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '5. After successful authentication, your account will be deleted and you will be redirected to login page.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '6. All of your data will be removed on the first on next coming month.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Divider(height: 20),
          Text(
            'Don\'t have access to BeenIt Messenger App?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildEmailSpanText(
            text:
                'If you no longer have the app installed and wish to delete your account, please send an email with your email address or phone number associated with your account and We will process your request and delete your account or data for you. Kindly send your account info at ',
          ),
        ],
      ),
    );
  }

  RichText _buildEmailSpanText({required String text}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 16),
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
