import 'package:flutter/material.dart';

class Product{
  Key key;
  String id, name;
  int  choice;
  double price;
  List<dynamic> items;
  String image;

  Product({Key key,
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.items,
    this.choice,
    this.image
  });
  
  String getId(){
    return id;
  }
  
  String getName() => name;
  
  int getChoice() => choice;
  
  double getPrice() => price;

  List<dynamic> getItems() => items;

  String getImage() => image;

  void setId(String id) => this.id = id;

  void setName(String name) => this.name = name;

  void setChoice(int choice) => this.choice = choice;

  void setPrice(double price) => this.price = price;

  void setItems(List<String> items) => this.items = items;

  void setImage(String image) => this.image = image;

  @override
  String toString() {
    return "id: " + id
        + '\nName:' + name
        + '\nChoice: ' + choice.toString()
        + '\nPrice: ' + price.toString()
        + '\nItems: ' + items.toString()
        + '\nImage: ' + image;
  }
}