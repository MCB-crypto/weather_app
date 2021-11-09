class Temperature{
  double temperature=0;

  Temperature(this.temperature);

  Temperature.fromJson(Map<String, dynamic> json){
    temperature=json['temp'];
  }

  Map<String, dynamic> toJson() => {
    "temp": temperature,
  };

}