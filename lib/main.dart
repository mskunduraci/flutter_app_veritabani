// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app_veritabani/notlar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_veritabani/dbhelper.dart';

import 'package:flutter_app_veritabani/notdetay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not Programı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notlarım'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper dbHelper=DbHelper();
  List<Notlar> notlar=[] ;
  int count=0;
  Notlar nots=new Notlar(0, "", "");



  @override
  Widget build(BuildContext context) {
    getData();
    if(notlar==null)
    {
      //notlar.add(Notlar(0,"",""));
      notlar=<Notlar>[];

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: notListesi(),
      floatingActionButton: FloatingActionButton(
        onPressed: yeniVeriEkle,
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  ListView notListesi(){
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context,int position)=>Card(
          color: Colors.amber,
          elevation: 2.0,
          child: ListTile(
            leading: Icon(Icons.note),
            title: Text(this.notlar[position].baslik),
            subtitle:Text(this.notlar[position].icerik) ,
            onTap: ()
            {
              detayaGit(this.notlar[position]);
            },
          ),

        )
    );
  }
  void detayaGit(Notlar nots) async
  {
    bool sonuc=await Navigator.push(context,
        MaterialPageRoute(builder: (context)=>NotDetay(nots)));
    if(sonuc==true)
    {
      getData();
    }
  }
  void getData()
  {
    final todosFuture=helper.getNotlar();
    todosFuture.then((sonuc) =>
    {
      setState(()
      {
        notlar=sonuc as dynamic;
        count=notlar.length;
      }
      )
    }
    );

  }
  void yeniVeriEkle()
  {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotDetay(nots)));

    });
  }
}