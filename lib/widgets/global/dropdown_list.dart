import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class MultiCategorySelector extends StatefulWidget {
   const MultiCategorySelector({ Key? key }) : super(key: key);

  @override
  State<MultiCategorySelector> createState() => _MultiCategorySelectorState();
}

class _MultiCategorySelectorState extends State<MultiCategorySelector> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(onChanged: (List<String> x) {setState(() {
              selected = x;
            });
          }, options: const ['Hello', 'Hello', 'Hello', 'Hello', 'Hello', 'Hello'], selectedValues: selected, whenEmpty: 'Select Something',
      
    );
  }
}