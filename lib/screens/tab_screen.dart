import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../widgets/main_drawer.dart';

import 'favorite_screen.dart';
class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals ;

  const TabScreen(this.favoriteMeals) ;

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
   List<Map<String , Object>> _pages ;

  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
    { 'page' : CategoriesScreen(),
    'title' : 'Categories'
    },
    { 'page' :FavoriteScreen(widget.favoriteMeals) ,
    'title' : 'Your favories'
    },

    ];
    super.initState();
  }
  void _selectPage(int value){
    setState(() {
      _selectedPageIndex = value;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),),
      body:_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
      onTap: _selectPage ,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor:Theme.of(context).accentColor ,
      unselectedItemColor: Colors.white,
      currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("Category"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorite"),
          ),

        ],
      ),
      drawer:MainDrawer(),
    );
  }
}









