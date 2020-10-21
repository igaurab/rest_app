import 'package:protoype/constants/assets.dart';
import 'package:protoype/models/food_item.dart';

class Data {
  List<FoodItem> foodItems = [];
  Data() {
    FoodItem item1 = FoodItem(
        id: "1",
        name: "Paratha",
        category: "Cat1",
        price: "10.0",
        imageUrl: ImageAsset.paratha);
    FoodItem item2 = FoodItem(
        id: '2',
        name: "Paneer",
        category: "Cat1",
        price: "20.0",
        imageUrl: ImageAsset.paneer);
    FoodItem item3 = FoodItem(
        id: '3',
        name: "Dosa",
        category: "Cat2",
        price: "30.0",
        imageUrl: ImageAsset.dosa);
    FoodItem item4 = FoodItem(
        id: '3',
        name: "Chowmin",
        category: "Indian",
        price: "30.0",
        imageUrl: ImageAsset.chowmin);

    foodItems.add(item1);
    foodItems.add(item2);
    foodItems.add(item3);
    foodItems.add(item4);
  }
}

Data dummyData = new Data();
