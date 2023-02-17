import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/location_widget.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});
  static const routeName = "compass";
  @override
  State<CompassScreen> createState() => _CompassScreen();
}

class _CompassScreen extends State<CompassScreen>
    with SingleTickerProviderStateMixin {
  bool showRealCompass = false;
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Disable landscape mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: const HSLColor.fromAHSL(1, 0, 0, 0.05).toColor(),
      backgroundColor: Colors.white,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Builder(
        builder: (context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildChildren());
        },
      ),
      bottomNavigationBar: const BottomNavBar(
        showCompassGreen: true,
      ),
    );
  }

  Widget _buildCompassImage() {
    debugPrint("hello compass image");
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 18),
              child: SizedBox(
                height: 350,
                child: GestureDetector(
                    onTap: (() => setShowCompassImage()),
                    child: Image.asset('assets/images/compass_image.png')),
              ),
            ),
            OutlinedButton(
                onPressed: (() => setShowCompassImage()),
                child: const Text("Show compass"))
          ],
        ),
      ),
    );
  }

  List<Widget> buildChildren() {
    if (!showRealCompass) {
      return [_buildCompassImage()];
    }
    return [Expanded(child: _buildCompass())];
  }

  void setShowCompassImage() {
    setState(() {
      _controller.forward();
      showRealCompass = true;
    });
  }

  Widget _buildCompass() {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // might need to accound for padding on iphones
    return SlideTransition(
      position: _offsetAnimation,
      child: StreamBuilder<CompassEvent>(
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            compassBoxShadow(
                                spreadRadius: 1,
                                blueRadius: 5,
                                color:
                                    const Color.fromARGB(255, 169, 169, 169)),
                            compassBoxShadow(
                                blueRadius: 50,
                                spreadRadius: -60,
                                color: const Color.fromARGB(255, 255, 255, 255))
                          ],
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(189, 255, 255, 255),
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
                  ],
                ),
              ),
              const Expanded(
                child: LocationWidget(),
              )
            ]),
          );
        },
      ),
    );
  }

  BoxShadow compassBoxShadow(
      {required double blueRadius,
      required double spreadRadius,
      required Color color}) {
    return BoxShadow(
        blurRadius: blueRadius,
        spreadRadius: spreadRadius,
        offset: Offset.zero,
        color: color);
  }
}
