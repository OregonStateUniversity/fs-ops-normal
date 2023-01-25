import 'package:ops_normal/screens/compass_screen.dart';

import 'screens/about_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/how_to_screen.dart';
import 'screens/incident_response_pocket_guide_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/red_book_screen.dart';

class RouteMap {
  static final routes = {
    AboutScreen.routeName: (context) => const AboutScreen(),
    NewEstimateScreen.routeName: (context) => const NewEstimateScreen(),
    EstimateScreen.routeName: (context) => const EstimateScreen(),
    HowToScreen.routeName: (context) => const HowToScreen(),
    IncidentResponsePocketGuideScreen.routeName: (context) =>
        IncidentResponsePocketGuideScreen(),
    ModifyEstimateScreen.routeName: (context) => const ModifyEstimateScreen(),
    RedBookScreen.routeName: (context) => RedBookScreen(),
    CompassScreen.routeName: (context) => const CompassScreen()
  };
}
