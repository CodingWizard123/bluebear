import 'package:bluebear/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //Standardizing the user document and making it compatible with firebase
  // instantiate using fromFirebase and update using update
  late String id;
  bool googleLinked;
  bool githubLinked;
  bool linkedinLinked;
  bool resumeUploaded;

  User(
      {this.id = '',
      this.githubLinked = false,
      this.googleLinked = false,
      this.linkedinLinked = false,
      this.resumeUploaded = false});

  User.fromFirebase(DocumentSnapshot doc,
      {this.githubLinked = false,
      this.googleLinked = false,
      this.linkedinLinked = false,
      this.resumeUploaded = false}) {
    this.id = doc.id;
    this.githubLinked = doc.get(Constants.githubLinked);
    this.googleLinked = doc.get(Constants.googleLinked);
    this.linkedinLinked = doc.get(Constants.linkedinLinked);
  }

  void update() {
    FirebaseFirestore.instance
        .collection(Constants.usercollection)
        .doc(this.id)
        .update({
      Constants.googleLinked: this.googleLinked,
      Constants.githubLinked: this.googleLinked,
      Constants.linkedinLinked: this.googleLinked,
    });
  }
}
