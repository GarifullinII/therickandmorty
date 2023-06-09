import 'package:flutter/material.dart';
import 'package:therickandmorty/common/app_colors.dart';
import '../../domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            child: Image.network(person.image),
          )
        ],
      ),
    );
  }
}
