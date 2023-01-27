import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/svg.dart';
import '../screens/main_screen.dart';
import '../widgets/location_widget.dart';

class CompassScreen extends StatefulWidget {
  //const CompassScreen({super.key, this.buildNavBar});
  const CompassScreen({super.key});
  //final bool? buildNavBar;
  static const routeName = "compass";
  @override
  State<CompassScreen> createState() => _CompassScreen();
}

class _CompassScreen extends State<CompassScreen> {
  @override
  Widget build(BuildContext context) {
    //Disable landscape mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const HSLColor.fromAHSL(1, 0, 0, 0.05).toColor(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: () {
        //if (widget.buildNavBar == null) {
        //return null;
        //} else if (widget.buildNavBar == true) {
        /*return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Color.fromARGB(67, 255, 255, 255))
              ],
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(32, 133, 131, 131)),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Icon(Icons.home),
              )
            ],
          ),
        );*/
        //}
      }(),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(child: _buildCompass()),
          ],
        );
      }),
    );
  }

  Widget _buildCompass() {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // might need to accound for padding on iphones
    //var padding = MediaQuery.of(context).padding;
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        //IOS simmulator does not have a built-in sensor for the compass.
        //This will alayws return the condition below. It need to be run in a real device
        //Andriod emulator, physical devices  - [works]
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data?.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        //angel of the direction
        int ang = (direction.round());
        return Scaffold(
          body: Column(children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset.zero,
                              color: Color.fromARGB(255, 169, 169, 169)),
                          BoxShadow(
                              blurRadius: 50,
                              spreadRadius: -60,
                              offset: Offset.zero,
                              color: Color.fromARGB(255, 255, 255, 255))
                        ],
                        shape: BoxShape.circle,
                        color: Color.fromARGB(189, 255, 255, 255),
                      ),
                      child: Transform.rotate(
                        angle: ((direction > 0 ? direction : 0) *
                            (math.pi / 180) *
                            -1),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "assets/images/compass_style_clean.svg",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "$ang˚",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 65, 151, 70),
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  // Positioned(
                  //   // center of the screen - half the width of the rectangle
                  //   left: (width / 2) - ((width / 80) / 2),
                  //   // height - width is the non compass vertical space, half of that
                  //   top: (height - width) / 2,
                  //   child: SizedBox(
                  //     width: 10,
                  //     height: width / 10,
                  //     child: Container(
                  //       //color: HSLColor.fromAHSL(0.85, 0, 0, 0.05).toColor(),
                  //       color: Color.fromARGB(0, 235, 235, 235),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const Expanded(
              child: LocationWidget(),
            )
          ]),
        );
      },
    );
  }
}

//build cards that shows the location information - latitude , longtiude
//lat,log are updated when the location changes
