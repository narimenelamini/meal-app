import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "category_meals";
  final List<Meal> _availableMeals;

  const CategoryMealsScreen(this._availableMeals) ;
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;


   @override
  void didChangeDependencies() {
     final routeArg = ModalRoute.of(context).settings.arguments as Map<String , String>;
     final  categoryId = routeArg['id'];
     categoryTitle =  routeArg['title'];
      displayedMeals = widget._availableMeals.where((meal) {
       return meal.categories.contains(categoryId);}).toList();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


   void _removeMeal(String mealId){
      setState(() {
        displayedMeals.removeWhere((meal) => meal.id == mealId);
      });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle),),
      body: ListView.builder(
          itemBuilder: (ctx , index){
           return  MealItem(
                id:  displayedMeals[index].id,
                title:  displayedMeals[index].title,
               imageUrl : displayedMeals[index].imageUrl,
               duration: displayedMeals[index].duration,
               complexity: displayedMeals[index].complexity,
               affordability:displayedMeals[index].affordability,


           );

          },
        itemCount: displayedMeals.length ,
      ),
    );
  }
}



