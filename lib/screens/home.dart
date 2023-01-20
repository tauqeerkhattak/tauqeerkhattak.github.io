import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_practice/screens/stars/game_start/game_start.dart';
import 'package:web_practice/utils/assets.dart';
import 'package:web_practice/utils/size_config.dart';
import 'package:web_practice/widgets/custom_image.dart';

import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int imageNo = -1;
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Stack(
        children: [
          //Main Background
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: imageNo >= 0
                ? Image.asset(
                    Assets.images[imageNo],
                    fit: BoxFit.fill,
                    width: SizeConfig.width,
                    height: SizeConfig.height,
                  )
                : SizedBox(
                    width: SizeConfig.width,
                    height: SizeConfig.height,
                    child: const ColoredBox(
                      color: Colors.grey,
                    ),
                  ),
          ),

          Positioned(
            top: 0,
            child: _introBox(),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _footerText(),
            ),
          ),

          //Image0
          CustomImage(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GameStart(),
                ),
              );
            },
            onHover: (hovering) {
              if (hovering) {
                setState(() {
                  imageNo = 0;
                  textColor = const Color(0xfff5e2f6);
                });
              } else {
                setState(() {
                  imageNo = -1;
                  textColor = Colors.black;
                });
              }
            },
            imageNo: 0,
            center: Offset(
              SizeConfig.width * 0.65,
              SizeConfig.height * 0.2,
            ),
          ),

          //Image1
          CustomImage(
            onTap: () {
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  content: Text('in progress'),
                  actions: [],
                ),
              );
            },
            onHover: (hovering) {
              if (hovering) {
                setState(() {
                  imageNo = 1;
                  textColor = const Color(0xffebebeb);
                });
              } else {
                setState(() {
                  imageNo = -1;
                  textColor = Colors.black;
                });
              }
            },
            imageNo: 1,
            center: Offset(
              SizeConfig.width * 0.85,
              SizeConfig.height * 0.2,
            ),
          ),

          //Image2
          CustomImage(
            onTap: () {
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  content: Text('in progress'),
                  actions: [],
                ),
              );
            },
            onHover: (hovering) {
              if (hovering) {
                setState(() {
                  imageNo = 2;
                  textColor = const Color(0xff1d3735);
                });
              } else {
                setState(() {
                  imageNo = -1;
                  textColor = Colors.black;
                });
              }
            },
            imageNo: 2,
            width: SizeConfig.width * 0.2 + 250,
            center: Offset(
              SizeConfig.width * 0.75,
              SizeConfig.height * 0.5,
            ),
          ),

          //Image3
          CustomImage(
            onTap: () {
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  content: Text('in progress'),
                  actions: [],
                ),
              );
            },
            onHover: (hovering) {
              if (hovering) {
                setState(() {
                  imageNo = 3;
                  textColor = const Color(0xffe2e2e7);
                });
              } else {
                setState(() {
                  imageNo = -1;
                  textColor = Colors.black;
                });
              }
            },
            imageNo: 3,
            center: Offset(
              SizeConfig.width * 0.65,
              SizeConfig.height * 0.8,
            ),
          ),

          //Image4
          CustomImage(
            onTap: () {
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  content: Text('in progress'),
                  actions: [],
                ),
              );
            },
            onHover: (hovering) {
              if (hovering) {
                setState(() {
                  imageNo = 4;
                  textColor = const Color(0xfff2f6ed);
                });
              } else {
                setState(() {
                  imageNo = -1;
                  textColor = Colors.black;
                });
              }
            },
            imageNo: 4,
            center: Offset(
              SizeConfig.width * 0.85,
              SizeConfig.height * 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _introBox() {
    return SizedBox(
      height: SizeConfig.height,
      width: SizeConfig.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: textColor,
                width: 5,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Tauqeer Ahmed Khattak',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(Constants.githubUri));
                  },
                  child: Text(
                    '< github.com/tauqeerkhattak />',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: Assets.socials.map((social) {
                      return _buildSocial(social);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocial(String link) {
    return InkWell(
      onTap: () async {
        String linkToGo = '';
        switch (link) {
          case Assets.linkedin:
            linkToGo = Constants.linkedin;
            break;
          case Assets.email:
            linkToGo = Constants.email;
            break;
          case Assets.facebook:
            linkToGo = Constants.facebook;
            break;
        }
        if (await canLaunchUrl(Uri.parse(linkToGo))) {
          launchUrl(Uri.parse(linkToGo));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: textColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          link,
          height: 30,
          width: 30,
          color: textColor,
        ),
      ),
    );
  }

  Widget _footerText() {
    return Text(
      'Made with \u2764 and Flutter',
      style: TextStyle(
        fontSize: 18,
        color: textColor,
      ),
    );
  }
}
