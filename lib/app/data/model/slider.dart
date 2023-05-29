class SliderModel {
  dynamic image;
  dynamic thumb;
  dynamic url;
  dynamic desc;

  SliderModel({this.image, this.thumb, this.url, this.desc});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      image: json['image'],
      thumb: json['thumb'],
      url: json['url'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['thumb'] = thumb;
    data['url'] = url;
    data['desc'] = desc;
    return data;
  }
}
