const functions = require("firebase-functions");

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
exports.createDoc = functions.auth.user().onCreate((user) => {
  return admin.firestore().doc("users/"+user.uid).set({
    googleLinked: false,
    githubLinked: false,
    linkedinLinked: false,
  });
});

// for vectorization we can tokenize sentences and include the original
// categorization of the data.

// exports.vectorizeGoogle = functions.firestore.document().onUpdate((change)=>{
// if (change.after.get("googleLinked") == true){

// }
// });

// exports.vectorizeGithub = functions.firestore.document().onUpdate((change)=>{
// if (change.after.get("googleLinked") == true){

// }
// });

// exports.vectorizeLinkedIn = functions.firestore.document()
// .onUpdate((change)=>{
// if (change.after.get("googleLinked") == true){

// }
// });

// exports.vectorizeResume = functions.firestore.document().onUpdate((change)=>{
// if (change.after.get("googleLinked") == true){

// }
// });
