class OgretmenKisiselBilgileri {
  String? kuladi;
  String? eposta;
  String? minikResim;

  OgretmenKisiselBilgileri({this.kuladi, this.eposta, this.minikResim});

  OgretmenKisiselBilgileri.fromJson(Map<String,dynamic> json){
    kuladi=json['username'];
    eposta=json['email'];
    minikResim=json['urlAvatar'];
  }

}
