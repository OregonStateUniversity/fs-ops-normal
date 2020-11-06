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


  void addOrder(Estimate order){
    orders.add(order);
  }

  void removeOrder(Estimate order){
    orders.remove(order);
  }
}