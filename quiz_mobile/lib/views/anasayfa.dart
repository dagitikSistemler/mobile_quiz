import 'package:flutter/material.dart';
import 'package:quiz_mobile/services/database.dart';
import 'package:quiz_mobile/views/quiz_baslat.dart';
import 'package:quiz_mobile/views/quiz_olustur.dart';
import 'package:quiz_mobile/widgets/widgets.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    databaseService.QuizleriGetir().then((value) {
      setState(() {
        quizStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizListele(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QuizOlustur()));
        },
      ),
    );
  }

  Widget quizListele() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizCard(
                      imgUrl: snapshot.data.documents[index].data["quizImageUrl"],
                      description: snapshot.data.documents[index].data["quizDescription"],
                      title: snapshot.data.documents[index].data["quizTitle"],
                      quizId: snapshot.data.documents[index].data["quizId"],
                    );
                  });
        },
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  // const QuizCard({Key key}) : super(key: key);

  final String imgUrl;
  final String title;
  final String description;
  final String quizId;

  QuizCard(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizBaslat(quizId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 24,
                  fit: BoxFit.cover,
                )),
            Container(
              // color: Colors.black38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black38,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
