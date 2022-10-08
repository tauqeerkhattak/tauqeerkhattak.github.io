import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/utils/assets.dart';
import 'package:web_practice/utils/size_config.dart';
import 'package:web_practice/widgets/custom_image.dart';

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
            child: SizedBox(
              height: SizeConfig.height,
              width: SizeConfig.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tauqeer Ahmed Khattak',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.courierPrime(
                      color: textColor,
                      fontSize: 44,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '< github.com/tauqeerkhattak />',
                    style: GoogleFonts.courierPrime(
                      color: textColor,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Image0
          CustomImage(
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
}
