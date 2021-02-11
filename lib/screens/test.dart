// import 'package:flutter/material.dart';
// import 'package:test/test.dart';
// //import 'package:hose_jockey/models/estimate.dart';

// //void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _textFieldController = TextEditingController();
//   final GlobalKey<TodoList> _key = GlobalKey();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     _textFieldController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(backgroundColor: Colors.pink[100], title: Text('Todo List')),
//       //LISTVIEW BUILDER
//       body: TodoListS(
//         key: _key,
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add), onPressed: () => _displayDialog(context)),
//     );
//   }

//   _displayDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Insert Your to do'),
//             content: TextField(
//               controller: _textFieldController,
//               decoration: InputDecoration(hintText: "ie. Wash dishes"),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               FlatButton(
//                 child: Text('ADD'),
//                 onPressed: () {
//                   /*var todo =  Todo(title: _textFieldController.value.text);
//                   todol.setTodo(todo);*/

//                   _key.currentState
//                       .setTodo(Todo(title: _textFieldController.text));
//                   setState(() {

//                   });
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
// }

// // LIST CLASS
// class Todo {
//   String title;

//   Todo({
//     this.title,
//   });

//   factory Todo.fromJson(Map<String, dynamic> json) => Todo(
//         title: json["title"] == null ? null : json["title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title == null ? null : title,
//       };
// }

// // LIST MOCK DATA
// class TodoListS extends StatefulWidget {
//   TodoListS({Key key}) : super(key: key);
//   @override
//   TodoList createState() => TodoList();
// }

// class TodoList extends State<TodoListS> {
//   List<Todo> todos = [Todo(title: 'Checktheicon'), Todo(title: 'help me')];

//   void setTodo(Todo todo) {
//     todos.add(todo);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: todos.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(todos[index].title),
//           //leading: Icon(todos[index].icons),
//         );
//       },
//     );
//   }
// }

// LISTVIEW BUILDER
//Widget myListView(BuildContext context, List<Todo> todos) {
  // backing data
 // return 
//}

//////// center appbar thing

//centerTitle: true,

/////////print line/////////////////////
///print ('$orders');

/////final order screen
///
///  @override
  // Widget build(BuildContext context) {
  //   final Estimate estimate = ModalRoute.of(context).settings.arguments;
  //   //var hoses = estimate.trunkLineLength;
  //   //var acres = estimate.acres;
  //   estimate.initialLineCalculation();

  //   print ('$estimate');
  //   //print ('$hoses');
  //   //print ('$acres');


  // estimate changes

  //  Estimate({this.name, this.acres, this.timeStamp, this.trunkLineLength});

  // void initialLineCalculation(){
  //   trunkLineLength = BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;
  //   latLineLength = trunkLineLength ~/ 2;
  //   toyLineLength = latLineLength ~/ 2;
  // }

  // @override
  // String toString() {
  //   return 'Name: ${this.name}, Trunk: ${this.trunkLineLength}, Acres: ${this.acres}';
  // }
/////////////////////////////////////////////////////////////////////////////////
//  ORDER SCREEN STATE TESTS  ///////

// class OrderScreen extends StatefulWidget{
  
//   static const routeName = 'orderScreen';

//   //final Estimate estimate;

//   //OrderScreen({this.estimate});

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {

//   final Estimate estimate;

//   _OrderScreenState({this.estimate});

//   final testController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     testController.addListener(_updateToLatestValue);
//   }

//   @override
//   void dispose() { 
//     testController.dispose();
//     super.dispose();
//   }

//   _updateToLatestValue() {
//     estimate.trunkLineLength = int.parse(testController.text);
//   }

//   var formKey = GlobalKey<FormState>();
//   //final orderEntryField = OrderFields();

//   ////////////
  
//   Widget trunkLineRow(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Flexible(
//           flex: 2,
//           child: Text(
//             "Trunk Line",
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//         Flexible(
//           flex: 2,
//           child: TextFormField(
//             initialValue: estimate.trunkLineLength.toString(),
//             controller: testController,
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             onSaved: (value){
//               print('${estimate.trunkLineLength} => $value');
//               estimate.trunkLineLength = int.parse(value);
//               print('${estimate.trunkLineLength} => $value');
//             },
//             validator: (value){
//               if(value.isEmpty){
//                 return "Needs some value";
//               } else{
//                 return null;
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //TODO: implement build
//     throw UnimplementedError();
//   }


// }



//////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// //import 'new_estimate_screen.dart';
// //import 'results_screen.dart';

// class MyListView extends StatefulWidget {
// @override
// _MyListViewState createState() => _MyListViewState();
//  }

// class _MyListViewState extends State<MyListView> {
// final countries = [
// 'Pakistan',
// 'France',
// 'Spain'
// ];

// @override
// Widget build(BuildContext context) {
// return Scaffold(
//   body: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: ListView.separated(
//         itemCount: countries.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(countries[index]),
//           );
//         },

//         separatorBuilder: (context, index){

//           return Divider();
//   },
//         ),
//   ),
//   floatingActionButton: FloatingActionButton(
//     child: Icon(Icons.add),
//     onPressed: addItem,
//   ),
//   );
//    }


// void addItem(){

// setState(() {
//   countries.add(countries[0]);
// });

// }

// }

///////////////////////////////////////////////////////////////////////////////

          ////my attempt to get list tiles to work inside cards
                // padding: const EdgeInsets.all(8),
                // child: Card(
                //   elevation: 5.0,
                //   color: Colors.blue[100],
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(5.0)
                //   ),
                  
                  //margin: EdgeInsets.fromLTRB(2, 1, 2, 0),
                  // child: Container(
                  //   child: ListView.builder(
                  //     //padding: EdgeInsets.only(left: 8),
                  //     itemCount: fires.length,
                  //     itemBuilder: (BuildContext context, index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => SelectedEngagement()),
                  //           );
                  //         },
                  //         child: ListTile(
                  //           title: Text('${fires[index].name}'),
                  //           subtitle: Text('${fires[index].size}'),
                  //         )
                  //       );
                  //     }
                  //   )
                  // ),
                //),

/////////////////////////////////////////////////////////////////////////////////////////
///
///trailing dropdown menu
///
  // static const menuItems = <String>[
    //   'Edit',
    //   'Close(Mark \'Old\')',
    // ];

    // final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
    //     .map(
    //       (String value) => PopupMenuItem<String>(
    //         value: value,
    //         child: Text(value),
    //       ),
    //     )
    //     .toList();

    // String _popBtnSelectVal;

/// Inside ListTile  ///

  // trailing: PopupMenuButton<String>(
  //   onSelected: (String newVal) {
  //     _popBtnSelectVal = newVal;
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar( content: Text(_popBtnSelectVal)),
  //     );
  //   },
  //   itemBuilder: (BuildContext context) => _popUpMenuItems,
  // ),







// class FoodOrder {
//   static fromMap(Map<String, Object> map);

//   noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }




// void main() {
//   test('New orders properties should have correct data values', () {
//     const name = 'Fake Order';
//     final date = DateTime.parse('01-01-2021');
//     const deliveryLocation = '123 Hungry St';
//     const utensils = 13;
//     const tortillas = true;
//     const salsa = false;
//     const protein = 'barbacoa';

//     final lunchOrder = FoodOrder.fromMap({
//       'name' : name,
//       'date' : date,
//       'location' : deliveryLocation,
//       'utensils' : utensils,
//       'tortillas' : tortillas,
//       'salsa' : salsa,
//       'protein' : protein
//     });

//     expect(lunchOrder.name, name);
//     expect(lunchOrder.date, date);
//     expect(lunchOrder.location, deliveryLocation);
//     expect(lunchOrder.utensils, utensils);
//     expect(lunchOrder.tortillas, tortillas);
//     expect(lunchOrder.salsa, salsa);
//     expect(lunchOrder.protein, protein);
//   });
// }


/////////  BOTTOM BAR DEMO   /////////////
// import 'dart:async';

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:circular_reveal_animation/circular_reveal_animation.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Animated Navigation Bottom Bar'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   final autoSizeGroup = AutoSizeGroup();
//   var _bottomNavIndex = 0; //default index of first screen

//   AnimationController _animationController;
//   Animation<double> animation;
//   CurvedAnimation curve;

//   final iconList = <IconData>[
//     Icons.brightness_5,
//     Icons.brightness_4,
//     Icons.brightness_6,
//     Icons.brightness_7,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final systemTheme = SystemUiOverlayStyle.light.copyWith(
//       systemNavigationBarColor: HexColor('#373A36'),
//       systemNavigationBarIconBrightness: Brightness.light,
//     );
//     SystemChrome.setSystemUIOverlayStyle(systemTheme);

//     _animationController = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     );
//     curve = CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.5,
//         1.0,
//         curve: Curves.fastOutSlowIn,
//       ),
//     );
//     animation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(curve);

//     Future.delayed(
//       Duration(seconds: 1),
//       () => _animationController.forward(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: HexColor('#373A36'),
//       ),
//       body: NavigationScreen(
//         iconList[_bottomNavIndex],
//       ),
//       floatingActionButton: ScaleTransition(
//         scale: animation,
//         child: FloatingActionButton(
//           elevation: 8,
//           backgroundColor: HexColor('#FFA400'),
//           child: Icon(
//             Icons.brightness_3,
//             color: HexColor('#373A36'),
//           ),
//           onPressed: () {
//             _animationController.reset();
//             _animationController.forward();
//           },
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: AnimatedBottomNavigationBar.builder(
//         itemCount: iconList.length,
//         tabBuilder: (int index, bool isActive) {
//           final color = isActive ? HexColor('#FFA400') : Colors.white;
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 iconList[index],
//                 size: 24,
//                 color: color,
//               ),
//               const SizedBox(height: 4),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: AutoSizeText(
//                   "brightness $index",
//                   maxLines: 1,
//                   style: TextStyle(color: color),
//                   group: autoSizeGroup,
//                 ),
//               )
//             ],
//           );
//         },
//         backgroundColor: HexColor('#373A36'),
//         activeIndex: _bottomNavIndex,
//         splashColor: HexColor('#FFA400'),
//         notchAndCornersAnimation: animation,
//         splashSpeedInMilliseconds: 300,
//         notchSmoothness: NotchSmoothness.defaultEdge,
//         gapLocation: GapLocation.center,
//         leftCornerRadius: 32,
//         rightCornerRadius: 32,
//         onTap: (index) => setState(() => _bottomNavIndex = index),
//       ),
//     );
//   }
// }

// class NavigationScreen extends StatefulWidget {
//   final IconData iconData;

//   NavigationScreen(this.iconData) : super();

//   @override
//   _NavigationScreenState createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> animation;

//   @override
//   void didUpdateWidget(NavigationScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.iconData != widget.iconData) {
//       _startAnimation();
//     }
//   }

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//     super.initState();
//   }

//   _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.white,
//       child: Center(
//         child: CircularRevealAnimation(
//           animation: animation,
//           centerOffset: Offset(80, 80),
//           maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
//           child: Icon(
//             widget.iconData,
//             color: HexColor('#FFA400'),
//             size: 160,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }




///////  REORDER LIST DEMO  //////////
///
import 'package:flutter/material.dart';

class ReorderableViewPage extends StatefulWidget {
  List<String> item = ["Clients","Designer","Developer","Director",
    "Employee", "Manager", "Worker","Owner"];
  @override
  _ReorderableViewPageState createState() => _ReorderableViewPageState();
}

class _ReorderableViewPageState extends State<ReorderableViewPage> {

  void reorderData(int oldindex, int newindex){
    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final items =widget.item.removeAt(oldindex);
      widget.item.insert(newindex, items);
    });
  }

  void sorting(){
    setState(() {
      widget.item.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Reorderable ListView In Flutter",
          style: TextStyle(color: Colors.pinkAccent[100]),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.sort_by_alpha),
              tooltip:"Sort",
              onPressed: sorting
          ),
        ],
      ),
      body: ReorderableListView(
        children: <Widget>[
          for(final items in widget.item)
            Card(
              color: Colors.blueGrey,
              key: ValueKey(items),
              elevation: 2,
              child: ListTile(
                title: Text(items),
                leading: Icon(Icons.work,color: Colors.black,),
              ),
            ),
        ],
        onReorder: reorderData,

      ),
    );
  }
}
