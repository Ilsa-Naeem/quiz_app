import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 32,

          ),

          children: <TextSpan>[

            TextSpan(
              text: 'Quiz', style: TextStyle(fontWeight: FontWeight.w600
                , color: Colors.black54),
            ),
            TextSpan(text: 'App', style: TextStyle(fontWeight: FontWeight.w600
                , color: Colors.orangeAccent)),
          ],
        ),

      ),
    );
  }
}
