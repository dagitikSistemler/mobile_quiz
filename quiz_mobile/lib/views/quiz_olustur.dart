import 'package:flutter/material.dart';
import 'package:quiz_mobile/services/database.dart';
import 'package:quiz_mobile/views/soruEkle.dart';
import 'package:quiz_mobile/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class QuizOlustur extends StatefulWidget {
  const QuizOlustur({Key key}) : super(key: key);

  @override
  _QuizOlusturState createState() => _QuizOlusturState();
}

class _QuizOlusturState extends State<QuizOlustur> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

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
                        labelText: "Quiz Image Url",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Image Url";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Quiz Title",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Quiz Title";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Quiz Description",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Quiz Description";
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        QuizEkle();
                      },
                      child: blueButton(context: context, label: "Create Quiz"),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
    );
  }

  void QuizEkle() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImageUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription
      };
      await databaseService.quizEkle(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SoruEkle(quizId)));
        });
      });
    }
  }
}
