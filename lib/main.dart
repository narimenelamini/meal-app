import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool> _filter = {
        'gluten' : false,
        'lactose' : false,
         'vegan' : false,
         'vegetarian' :false,
};
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters( Map<String , bool> _filterData){
     setState(() {
       _filter = _filterData;
       _availableMeals = DUMMY_MEALS.where((meal) {
         if(_filter['gluten'] && !meal.isGlutenFree)
           {return false;};
         if(_filter['lactose'] && !meal.isLactoseFree)
         {return false;};
         if(_filter['vegan'] && !meal.isVegan)
         {return false;};
         if(_filter['vegetarian'] && !meal.isVegetarian)
         {return false;};
         return true;

       }).toList();
     });
  }
  void _toggleFavorites(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex>=0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
      else{
        setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        });

    }
  }
  bool isFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1)
          ),
          body2: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1)
          ),
          title: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),

        )

      ),
      //home: MyHomePage(title: 'Meal App '),
      //home:CategoriesScreen(),
      routes: {
       '/':  (context) =>TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName : (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (context) => MealDetailScreen(_toggleFavorites,isFavorite),
        FiltersScreen.routeName : (context) => FiltersScreen(_filter , _setFilters),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key key,  this.title}) ;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:null

    );
  }
}
