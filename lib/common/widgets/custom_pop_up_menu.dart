import 'package:flutter/material.dart';

enum Option {edit, delete, duplicate}

/// Custom menu widget used to edit, delete and duplicate items
class CustomPopUpMenu extends StatelessWidget
{
  final Function onDelete;
  final Function onEdit;
  final Function onDuplicate;
  final double textSize;
  final Color iconColor;

  CustomPopUpMenu({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.onDuplicate,
    this.textSize = 20,
    this.iconColor = Colors.white
  });

  @override
  Widget build(BuildContext context)
  {
    return PopupMenuButton<Option>(
      position: PopupMenuPosition.under,
      icon: Icon(Icons.more_vert),
      iconColor: iconColor,
      iconSize: 30,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>> [
        PopupMenuItem<Option>
        (
          value: Option.edit,
          onTap: ((){
            onEdit();
          }),
          child: Text(
            "Edit",
            style: TextStyle(
              fontSize: textSize
            )
          )
        ),
        PopupMenuItem<Option>
        (
          value: Option.delete,
          onTap: ((){
            onDelete();
          }),
          child: Text(
            "Delete",
            style: TextStyle(
              fontSize: textSize
            )
          )
        ),
        PopupMenuItem<Option>
        (
          value: Option.duplicate,
          onTap: ((){
            onDuplicate();
          }),
          child: Text(
            "Duplicate",
            style: TextStyle(
              fontSize: textSize
            )
          )
        ),
      ]
    );
  }
}