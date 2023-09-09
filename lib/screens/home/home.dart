import 'package:flutter/material.dart';
import 'package:web_practice/screens/home/views/main_design.dart';
import 'package:web_practice/utils/size_config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final controller = ScrollController();
  // double height = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     height = SizeConfig.height;
  //     setState(() {});
  //     controller.addListener(() {
  //       final temp = SizeConfig.height - controller.offset;
  //       if (temp > 0) {
  //         height = temp;
  //       } else {
  //         height = 0;
  //       }
  //       setState(() {});
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height,
            flexibleSpace: Container(
              // duration: const Duration(milliseconds: 100),
              height: SizeConfig.height,
              child: MainDesign(
                offset: SizeConfig.height,
              ),
            ),
          ),
          // SizedBox(
          //   height: SizeConfig.height,
          //   child: const Text('Projects'),
          // ),
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => SizedBox(
                height: SizeConfig.height,
                child: const Text('Projects'),
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   controller: controller,
      //   child: Column(
      //     children: [
      //       AnimatedContainer(
      //         duration: const Duration(milliseconds: 100),
      //         height: height,
      //         child: MainDesign(
      //           offset: controller.offset,
      //         ),
      //       ),
      //       SizedBox(
      //         height: SizeConfig.height,
      //         child: const Text('Projects'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
