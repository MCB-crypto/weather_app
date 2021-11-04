class Weather {
  String description="";
  String icon="";

  Weather(this.description, this.icon);

  Weather.fromJson(Map<String, dynamic> json){
    description=json['description'];
    icon=json['icon'];
  }
}