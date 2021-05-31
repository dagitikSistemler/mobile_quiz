import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_mobile/models/soru_modelleri.dart';
import 'package:quiz_mobile/services/database.dart';
import 'package:quiz_mobile/views/result.dart';
import 'package:quiz_mobile/widgets/quiz_baslat_widget.dart';
import 'package:quiz_mobile/widgets/widgets.dart';

class QuizBaslat extends StatefulWidget {
  final String quizId;

  QuizBaslat(this.quizId);

  // const QuizBaslat({Key key}) : super(key: key);

  @override
  _QuizBaslatState createState() => _QuizBaslatState();
}

int kalan = 0;
int soruSayisi = 0;
int _dogru = 0;
int _yanlis = 0;
int _puan = 0;

class _QuizBaslatState extends State<QuizBaslat> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  SoruModelleri getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot) {
    SoruModelleri soruModelleri = new SoruModelleri();
    soruModelleri.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];
    options.shuffle();
    soruModelleri.optional1 = options[0];
    soruModelleri.optional2 = options[1];
    soruModelleri.optional3 = options[2];
    soruModelleri.optional4 = options[3];
    soruModelleri.correctOption = questionSnapshot.data["option1"];
    soruModelleri.answered = false;
    print(soruModelleri.correctOption.toLowerCase());
    return soruModelleri;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("${widget.quizId}");
    databaseService.QuizSorulariGetir(widget.quizId).then((val) {
      questionSnapshot = val;
      _puan = 0;
      _dogru = 0;
      _yanlis = 0;
      kalan = questionSnapshot.documents.length;
      soruSayisi = questionSnapshot.documents.length;
      print("$kalan soru listelendi");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              questionSnapshot == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: questionSnapshot.documents.length,
                      itemBuilder: (context, index) {
                        return QuizBaslatTile(
                          soruModelleri: getQuestionModelFromDataSnapshot(
                              questionSnapshot.documents[index]),
                          index: index,
                        );
                      })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        dogru: _dogru,
                        yanlis: _yanlis,
                        total: soruSayisi,
                      )));
        },
      ),
    );
  }
}

class QuizBaslatTile extends StatefulWidget {
  final SoruModelleri soruModelleri;
  final int index;

  QuizBaslatTile({this.soruModelleri, this.index});

  // const QuizBaslatTile({Key key}) : super(key: key);

  @override
  _QuizBaslatTileState createState() => _QuizBaslatTileState();
}

class _QuizBaslatTileState extends State<QuizBaslatTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${widget.index + 1}: ${widget.soruModelleri.question}",
            style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (!widget.soruModelleri.answered) {
                if (widget.soruModelleri.optional1 == widget.soruModelleri.correctOption) {
                  optionSelected = widget.soruModelleri.optional1;
                  widget.soruModelleri.answered = true;
                  _dogru = _dogru + 1;
                  kalan = kalan - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.soruModelleri.optional1;
                  widget.soruModelleri.answered = true;
                  _yanlis = _yanlis + 1;
                  kalan = kalan - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.soruModelleri.correctOption,
              description: widget.soruModelleri.optional1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              if (!widget.soruModelleri.answered) {
                if (widget.soruModelleri.optional2 == widget.soruModelleri.correctOption) {
                  optionSelected = widget.soruModelleri.optional2;
                  widget.soruModelleri.answered = true;
                  _dogru = _dogru + 1;
                  kalan = kalan - 1;
                  print("${widget.soruModelleri.correctOption}");
                  setState(() {});
                } else {
                  optionSelected = widget.soruModelleri.optional2;
                  widget.soruModelleri.answered = true;
                  _yanlis = _yanlis + 1;
                  kalan = kalan - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.soruModelleri.correctOption,
              description: widget.soruModelleri.optional2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              if (!widget.soruModelleri.answered) {
                if (widget.soruModelleri.optional3 == widget.soruModelleri.correctOption) {
                  optionSelected = widget.soruModelleri.optional3;
                  widget.soruModelleri.answered = true;
                  _dogru = _dogru + 1;
                  kalan = kalan - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.soruModelleri.optional3;
                  widget.soruModelleri.answered = true;
                  _yanlis = _yanlis + 1;
                  kalan = kalan - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.soruModelleri.correctOption,
              description: widget.soruModelleri.optional3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              if (!widget.soruModelleri.answered) {
                if (widget.soruModelleri.optional4 == widget.soruModelleri.correctOption) {
                  optionSelected = widget.soruModelleri.optional4;
                  widget.soruModelleri.answered = true;
                  _dogru = _dogru + 1;
                  kalan = kalan - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.soruModelleri.optional4;
                  widget.soruModelleri.answered = true;
                  _yanlis = _yanlis + 1;
                  kalan = kalan - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.soruModelleri.correctOption,
              description: widget.soruModelleri.optional4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
