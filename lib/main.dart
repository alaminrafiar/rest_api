import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//String stringResponse;

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //1.pura ta newar jnno jmn akhane ata nile pura data suppport sob asbe
  var stringResponse;
//1.amra jokhon data gulo nibo jmn vitore akta kisu tokhon ata diye shudhu support asbe
  late Map mapResponse;
  // 3.akta newer jnno
  late Map dataResponse;
  //4 ta jaygay change krte hbe kono kisu nite gelo akhane nite hbe then
  //ata setstate a cll krte hbe jmn kore krlm
  //then text er okhane cll krte hbe jeta chaibo seta dite hbe text er jaygay
  // uporer 3 ta sigle user er jnnp
  //ata list user er jnno
  late List listResponse;

  Future apicall() async {
    http.Response response;
    //ata single user er jnno
    //response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    //ata list user er jnno
    response =
    await http.get(Uri.parse("https://api.grapfood.com/api/product"));
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode(response.body);
        //dataResponse = mapResponse['support'];
        //single user er jnno oporer ta
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Demo '),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(listResponse[index]['image']
                      .toString()), //ata use kore hoyece pic newer jnno avatar a pic ace tai ata newa hoyece listResponse diye list er j data gulo ace seta newer jnno
                ),
                //niche id number ,email,2st last name agulo newer jnno ata newa hoyece
                //to string newa hoyece id name emai,agulo a k string a convert korar jnno
                Text(listResponse[index]['name'].toString()),
                Text(listResponse[index]['id'].toString()),
                Text(listResponse[index]['category_id'].toString()),
                Text(listResponse[index]['quantity'].toString()),
                Text(listResponse[index]['price'].toString()),
                Text(listResponse[index]['price'].toString()),
              ],
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse.length,
      ),

      //ata diye single a kmn kore ney seta dekhlam ..pore listview ,builder diye kmn kre ney seta dekhbo
      // body: Center(
      //   child: Container(
      //     height: 200,
      //     width: 300,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20), color: Colors.blue),
      //     child: Center(
      //       child: listResponse == null
      //           ? Container()
      //           : Text(listResponse[0].toString()),
      //           //list er jnno index use kora hoy akhane tai 0 use krce ata list er jnno
      //           //atar jnno  j index er man chaibo seta nibo [akhane index name 0 hole 0 2 hole 1] er por jodi kono kisu lage setar  jnno ['atar moddhe setar nam dibo']
      //     ),
      //   ),
      // ),
    );
  }
}