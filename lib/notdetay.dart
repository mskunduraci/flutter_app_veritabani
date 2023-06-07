import 'package:flutter/material.dart';
import 'package:flutter_app_veritabani/notlar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_veritabani/dbhelper.dart';

DbHelper helper=DbHelper();

class NotDetay extends StatefulWidget {
  final Notlar nots;
  NotDetay(this.nots);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotDetayState(nots);
  }
}

class NotDetayState extends State<NotDetay> {
  Notlar nots;
  NotDetayState(this.nots);

  TextEditingController baslikController=new TextEditingController();
  TextEditingController icerikController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Yeni Not Ekle'),
          TextField(
            controller: baslikController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Başlık")
            ),
          ),
          TextField(
            controller: icerikController,
            maxLines: 20,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("İçerik")
            ),
          ),
          ElevatedButton(onPressed: kaydet,
              child: Text('Yeni Not Ekle'))
        ],
      ),
    );
  }
  void kaydet()
  {
    nots.baslik=baslikController.text;
    nots.icerik=icerikController.text;
    if(nots.id!=0)
    {
      helper.updateNot(nots);
    }else{
      helper.insertNot(nots);
    }
    Navigator.pop(context,true);
  }

}