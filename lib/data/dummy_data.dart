import 'package:protoype/constants/assets.dart';
import 'package:protoype/models/food_item.dart';

class Data {
  List<FoodItem> foodItems = [];
  Data() {
    FoodItem item1 = FoodItem(
        id: "1",
        name: "Roasted Burger",
        category: "Cat1",
        price: "10.0",
        imageUrl: ImageAsset.burger);
    FoodItem item2 = FoodItem(
        id: '2',
        name: "Pizza",
        category: "Cat1",
        price: "20.0",
        imageUrl: ImageAsset.pizza);
    FoodItem item3 = FoodItem(
        id: '3',
        name: "French Fry",
        category: "Cat2",
        price: "30.0",
        imageUrl: ImageAsset.fry);
    FoodItem item4 = FoodItem(
        id: '3',
        name: "Special Paneer",
        category: "Indian",
        price: "30.0",
        imageUrl: ImageAsset.paneer);

    foodItems.add(item1);
    foodItems.add(item2);
    foodItems.add(item3);
    foodItems.add(item4);
  }
}

Data dummyData = new Data();
