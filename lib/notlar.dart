class Notlar {
  int id = 0;
  String baslik = "";
  String icerik = "";

  Notlar(int id, String b, String icerik) {
    this.id = id;
    this.baslik = b;
    this.icerik = icerik;
  }
  int get GetId=>id;
  String get GetBaslik=>baslik;
  String get GetIcerik=>icerik;
  set Setbaslik(String yeniBaslik) {this.baslik=yeniBaslik;}
  set SetIcerik(String yeniIcerik) {this.icerik=yeniIcerik;}
  set SetId(int yeniId) {this.id=yeniId;}
  Notlar.fromObject(dynamic o)
  {
    this.id=o["id"];
    this.baslik=o["baslik"];
    this.icerik=o["icerik"];
  }
  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();
    if(id!=0)
    {
      map["id"]=id;
    }
    map["baslik"]=baslik;
    map["icerik"]=icerik;

    return map;
  }
}