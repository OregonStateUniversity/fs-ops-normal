import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('App', (){

    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null){
        driver!.close();
      }
    });

    test('starts empty', () async{
      expect(await driver!.getText(find.text('Ops Normal')), "Ops Normal");
      expect(await driver!.getText(find.text('No Engagements Created Yet')), "No Engagements Created Yet");
    });

    test('add engagement', () async{
      final addEngagementButton = find.byValueKey('add engagement');
      final createEngagementButton = find.byValueKey('create engagement');
      await driver!.tap(addEngagementButton);
      await driver!.enterText("Test Fire");
      await driver!.tap(createEngagementButton);
      expect(await driver!.getText(find.text("Test Fire")), "Test Fire");
    });
  });
}