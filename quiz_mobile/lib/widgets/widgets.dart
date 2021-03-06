import 'package:flutter/material.dart';

Widget appBar(context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 22),
        children: <TextSpan>[
          TextSpan(
              text: ' Quiz',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
          TextSpan(
              text: 'Mobile',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    ),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 40,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(50),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 24),
    ),
  );
}
