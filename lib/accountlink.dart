import 'dart:html';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_any_logo/flutter_logo.dart';

class AccountLink extends StatefulWidget {
  final Function resetCounter;
  const AccountLink(this.resetCounter, {super.key});

  @override
  State<AccountLink> createState() => _AccountLinkState();
}

class _AccountLinkState extends State<AccountLink> {
  bool gitfinished = false;
  bool googlefinished = false;
  Future<UserCredential?> linkCredential(AuthProvider provider) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.currentUser?.linkWithPopup(provider);
      if (userCredential!.additionalUserInfo!.providerId ==
          provider.providerId) {
        await FirebaseFunctions.instance
            .httpsCallable('vectorize' + provider.providerId.split('.')[0])
            .call({
          'token': userCredential.additionalUserInfo!.authorizationCode,
          'uid': userCredential.user!.uid
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print(e.message);
          print("Unknown error.");
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'card2bg',
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  widget.resetCounter();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Help Me Learn More About Your Career",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('(( connect your accounts to work AI magic ))',
                      style: TextStyle(fontSize: 20)),
                  Container(
                    width: 1000,
                    height: 300,
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 300,
                          child: IconButton(
                              onPressed: () async {
                                UserCredential? user =
                                    await linkCredential(GithubAuthProvider());
                                setState(() {
                                  gitfinished = user!.credential != null;
                                });
                              },
                              icon: AnyLogo.coding.github.image(scale: 5)),
                        ),
                        Container(
                          width: 300,
                          child: IconButton(
                              onPressed: () async {
                                UserCredential? user =
                                    await linkCredential(GoogleAuthProvider());
                                setState(() {
                                  googlefinished = user!.credential != null;
                                });
                              },
                              icon: AnyLogo.media.gmail.image(scale: 5)),
                        ),
                        // Container(
                        //   width: 300,
                        //   child: IconButton(
                        //       onPressed: () async {
                        //         UserCredential linkedin = await FirebaseAuth
                        //             .instance
                        //             .signInWithProviderLinkedIn AuthProvider());
                        //       },
                        //       icon: AnyLogo.media.linkedin.image(scale: 2)),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1000,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        gitfinished
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.check_circle_outline_rounded),
                        // Icon(Icons.check_circle_outline_rounded),
                        googlefinished
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.check_circle_outline_rounded),
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
