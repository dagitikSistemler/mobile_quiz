import 'package:flutter/material.dart';
import 'package:quiz_mobile/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int dogru, yanlis, total;

  Results({@required this.dogru, @required this.yanlis, @required this.total});

  // const Results({Key key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.dogru}/${widget.total}",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                "You answered ${widget.dogru} answer correctly"
                " and ${widget.yanlis} answers incorrectly",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: blueButton(
                    context: context,
                    label: "Go to home",
                    buttonWidth: MediaQuery.of(context).size.width / 2),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
