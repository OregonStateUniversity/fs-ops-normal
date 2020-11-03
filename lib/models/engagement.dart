import 'estimate.dart';

class Engagement{
  String name;
  List<Estimate> orders;
  bool isActive;

  Engagement(String name, List<Estimate> orders, bool isActive){
    this.name = name;
    this.orders = orders;
    this.isActive = isActive;
  }


  void appendOrder(Object order){
    orders.add(order);
  }

  void removeOrder(Object order){
    orders.remove(order);
  }
}