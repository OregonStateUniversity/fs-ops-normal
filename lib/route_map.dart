import 'screens/about_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/how_to_screen.dart';
import 'screens/incident_response_pocket_guide_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/red_book_screen.dart';

class RouteMap {
  static final routes = {
      AboutScreen.routeName: (context) => AboutScreen(),
      NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
      EstimateScreen.routeName: (context) => EstimateScreen(),
      HowToScreen.routeName: (context) => HowToScreen(),
      IncidentResponsePocketGuideScreen.routeName: (context) =>
          IncidentResponsePocketGuideScreen(),
      ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
      EngagementScreen.routeName: (context) => EngagementScreen(),
      RedBookScreen.routeName: (context) => RedBookScreen(),
    };
}
