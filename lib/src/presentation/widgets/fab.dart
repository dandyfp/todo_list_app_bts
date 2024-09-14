import 'package:flutter/material.dart';
import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';

class FAB extends StatelessWidget {
  final VoidCallback onTap;
  const FAB({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 5,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.8),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 50.0,
          color: ghostWhite,
        ),
      ),
    );
  }
}
