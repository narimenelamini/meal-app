import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilter;
  final Map<String,bool> _currentFilters;

  const FiltersScreen( this._currentFilters,this.saveFilter, ) ;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}
    class _FiltersScreenState extends State<FiltersScreen>{
       bool _glutenFree = false;
       bool _lactoseFree = false ;
       bool _vegan = false ;
       bool _vegetarian = false;
       @override
        initState(){
         _glutenFree = widget._currentFilters['gluten'];
          _lactoseFree =  widget._currentFilters['lactose'];
          _vegan =  widget._currentFilters['vegan'];
          _vegetarian =  widget._currentFilters['vegetarian'];
         super.initState();
       }

       Widget buildSwitchListTile(String title , String desription , bool currentValue , Function updateValue){
         return SwitchListTile(
           value: currentValue,
           title: Text(title) ,
           subtitle: Text(desription),
           onChanged:updateValue,

         );
       }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Your Filters") , actions: [
         IconButton(
             onPressed: (){

            final Map<String,bool>selectedFilters = {
                 'gluten' : _glutenFree,
                 'lactose' : _lactoseFree,
                  'vegan' : _vegan,
                  'vegetarian' :_vegetarian,
    };
            widget.saveFilter(selectedFilters);
             },

             icon: Icon(Icons.save))
    ],),
    body: Column(
       children: [
         Container(
           padding: EdgeInsets.all(20),
           child: Text("Adjust your meal selection",
                     style: Theme.of(context).textTheme.title,
           ),
         ),
         Expanded(
             child: ListView(
               children: [
                 buildSwitchListTile(
                     "Gluten-Free",
                     "Only include Gluten-Free meals",
                     _glutenFree,
                         (newValue){
                       setState(() {
                         _glutenFree = newValue ;
                       });}
                 ),
                 buildSwitchListTile(
                  "Lactose-free",
                 "Only include Lactose-free meals",
                 _lactoseFree,
               (newValue){
                    setState(() {
                   _lactoseFree = newValue ;
                    });}
                    ),

                 buildSwitchListTile(
                     "Vegan",
                     "Only include Vegan meals",
                     _vegan,
                         (newValue){
                       setState(() {
                         _vegan = newValue ;
                       });}
                 ),

                 buildSwitchListTile(
                     "Vegetarian",
                     "Only include Vegetarian meals",
                     _vegetarian,
                         (newValue){
                       setState(() {
                         _vegetarian = newValue ;
                       });}
                 )
               ],
             ))
       ],
    ),
    drawer: MainDrawer(),

    );
    }
    }


