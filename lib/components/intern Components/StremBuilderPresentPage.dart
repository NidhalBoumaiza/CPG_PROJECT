import 'package:client/API/getSupervisorDataApi.dart';
import 'package:client/components/roundedButton.dart';
import 'package:client/models/internModel.dart';
import 'package:client/models/sepervisorModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../screens/PresentInternScreen.dart';
import '../../screens/affectInternPage.dart';
import '../../screens/homePage.dart';

List toFetchListIntern = [];

class StreamBuilderPresentPage extends StatefulWidget {
  const StreamBuilderPresentPage({Key? key}) : super(key: key);

  @override
  State<StreamBuilderPresentPage> createState() =>
      _StreamBuilderPresentPageState();
}

class _StreamBuilderPresentPageState extends State<StreamBuilderPresentPage> {
  late Stream<List<Supervisor>> supervisors;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Intern>>(
      stream: StreamAffectedIntern,
      builder: (context, snapshot) {
        print("result i want to see : \n");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("The stream is null .");
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );

          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 128,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 9,
                              left: 9,
                              child: ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: AssetImage(
                                            'images/${snapshot.data![index].picture}')
                                        as ImageProvider,
                                    fit: BoxFit.cover,
                                    width: 106,
                                    height: 106,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 120,
                              child: Text(
                                "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 128,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_rounded,
                                    size: 12,
                                  ),
                                  Text(
                                    " ${snapshot.data![index].email}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 90,
                              left: 127,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    " ${snapshot.data![index].instituteName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: 128,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    size: 15,
                                  ),
                                  Text(
                                    " ${snapshot.data![index].phoneNumber}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: 300,
                              child: RoundIconButton(
                                onPressAction: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          title: Text(
                                            '${snapshot.data![index].firstName} ${snapshot.data![index].lastName}',
                                            style: TextStyle(
                                                color: Color(0xFF3490CC)),
                                          ),
                                          content: Container(
                                            height: 140,
                                            width: 310,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.school,
                                                            color: Color(
                                                                0xFF3490CC),
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    7, 0, 0, 0),
                                                            child: Flexible(
                                                              child: Text(
                                                                "${snapshot.data![index].instituteName}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Dubai',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.email,
                                                            color: Color(
                                                                0xFF3490CC),
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    7, 0, 0, 0),
                                                            child: Text(
                                                              "${snapshot.data![index].email}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Dubai',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.phone_rounded,
                                                            color: Color(
                                                                0xFF3490CC),
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    7, 0, 0, 0),
                                                            child: Text(
                                                              "${snapshot.data![index].phoneNumber}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Dubai',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .perm_identity_rounded,
                                                            color: Color(
                                                                0xFF3490CC),
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    7, 0, 0, 0),
                                                            child: Text(
                                                              "${snapshot.data![index].cin}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Dubai',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: Icons.info,
                                colour: Color(0xffC9F4AA),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 300,
                              child: RoundIconButton(
                                icon: Icons.timer_off_sharp,
                                colour: Color(0xffFF6464),
                                onPressAction: () async {
                                  var dateee = DateTime.parse(
                                          DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now()))
                                      .toIso8601String();
                                  print(dateee);
                                  var data = {
                                    "absentDay": dateee,
                                  };
                                  // print(data['absentDay'].runtimeType);
                                  var encodedData = jsonEncode(data);
                                  http.Response res = await http.patch(
                                    Uri.parse(
                                      '$Kurl/api/v1/interns/marquerAbsence/${snapshot.data![index].id}',
                                    ),
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                    body: encodedData,
                                  );
                                  if (res.statusCode == 201) {
                                    final snackBar = SnackBar(
                                      content: const Text('Yay! A SnackBar!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    print('erroooooooooooooooooooooooooor');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 1.5,
                        indent: 2,
                        endIndent: 2,
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              );
            } else {
              return Text("There is not any interns yet.");
            }
          default:
            return Text('Non intern exist.');
        }
      },
    );
  }

  void launchEmail(
      {required String toEmail,
      required String subject,
      required String message}) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
