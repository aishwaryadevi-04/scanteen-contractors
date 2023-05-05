import 'package:flutter/material.dart';


class DeleteFood extends StatefulWidget {
  const DeleteFood({super.key});

  @override
  State<DeleteFood> createState() => _DeleteFoodState();
}

class _DeleteFoodState extends State<DeleteFood> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:const  Color(0XFF2B2B2B),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Do you want to delete?',
            style: TextStyle(
              color: Color(0xFFFCD9B8),
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Color(0xFFE09145),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
            SizedBox(
              width: 250,
              child: Divider(
                color: const Color(0xFFBDBDBD).withOpacity(0.1),
                thickness: 1.0,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
            SizedBox(
              width: 250,
              child: Divider(
                color: const Color(0xFFBDBDBD).withOpacity(0.1),
                thickness: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
