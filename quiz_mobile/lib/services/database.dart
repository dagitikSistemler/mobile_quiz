import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> quizEkle(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> QuizSoruEkle(Map questionData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  QuizleriGetir() async {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  QuizSorulariGetir(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }
}
