import 'package:flutter/material.dart';

enum Option {edit, delete, duplicate}

class RoundCardPopUpMenu extends StatelessWidget
{
  final Function onDelete;
  final Function onEdit;
  final double textSize;

  RoundCardPopUpMenu({
    super.key,
    required this.onDelete,
    required this.onEdit,
    this.textSize = 20
  });

  @override
  Widget build(BuildContext context)
  {

    return PopupMenuButton<Option>(
      position: PopupMenuPosition.under,
      icon: Icon(Icons.more_vert),
      iconColor: Colors.white,
      iconSize: 30,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>> [
        PopupMenuItem<Option>
        (
          value: Option.edit,
          onTap: (){
            onEdit();
          },
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
          onTap: (){
            onDelete();
          },
          child: Text(
            "Delete",
            style: TextStyle(
              fontSize: textSize
            )
          )
        ),
      ]
    );
  }
}