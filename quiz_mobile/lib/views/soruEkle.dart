import 'package:flutter/material.dart';
import 'package:quiz_mobile/services/database.dart';
import 'package:quiz_mobile/widgets/widgets.dart';

class SoruEkle extends StatefulWidget {
  final String quizId;

  SoruEkle(this.quizId);

  // const SoruEkle({Key key}) : super(key: key);

  @override
  _SoruEkleState createState() => _SoruEkleState();
}

class _SoruEkleState extends State<SoruEkle> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Question",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Question";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Option1(Correct Answer)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Option1(Correct Answer)";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Option2",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Option2";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Option3",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Option3";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Option4",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Option4";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: blueButton(
                              context: context,
                              label: "Submit",
                              buttonWidth: MediaQuery.of(context).size.width / 2 - 36),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 24),
                        GestureDetector(
                            child: blueButton(
                                context: context,
                                label: "Add Question",
                                buttonWidth: MediaQuery.of(context).size.width / 2 - 36),
                            onTap: () {
                              QuizSoruEkle();
                            }),
                      ],
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
    );
  }

  void QuizSoruEkle() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      await databaseService.QuizSoruEkle(questionMap, widget.quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
}
