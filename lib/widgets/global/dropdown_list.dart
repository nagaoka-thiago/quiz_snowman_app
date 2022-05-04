import 'package:flutter/material.dart';

class DropDownListMultiselect extends StatefulWidget {
  const DropDownListMultiselect({ Key? key }) : super(key: key);

  @override
  State<DropDownListMultiselect> createState() => _DropDownListMultiselect();
}

class _DropDownListMultiselect extends State<DropDownListMultiselect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}



List<DropdownMenuItem<String>> get dropdownCategories {
    List<DropdownMenuItem<String>> menuCategories = [
      const DropdownMenuItem(child: Text("Any"), value: "Any"),
      const DropdownMenuItem(
          child: Text("Arts & Literature"), value: "Arts & Literature"),
      const DropdownMenuItem(child: Text("Film & TV"), value: "Film & TV"),
      const DropdownMenuItem(
          child: Text("Food & Drink"), value: "Food & Drink"),
      const DropdownMenuItem(
          child: Text("General Knowledge"), value: "General Knowledge"),
      const DropdownMenuItem(child: Text("Geography"), value: "Geography"),
      const DropdownMenuItem(child: Text("History"), value: "History"),
      const DropdownMenuItem(child: Text("Music"), value: "Music"),
      const DropdownMenuItem(child: Text("Science"), value: "Science"),
      const DropdownMenuItem(
          child: Text("Society & Culture"), value: "Society & Culture"),
      const DropdownMenuItem(
          child: Text("Sport & Leisure"), value: "Sport & Leisure"),
    ];
    return menuCategories;
  }
