class FacebookModel {
  String? name;
  String? email;
  FacebookPhotoModel? facebookPhotoModel;
  String? id;

  FacebookModel({this.facebookPhotoModel, this.name, this.email, this.id});

  FacebookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    facebookPhotoModel = FacebookPhotoModel.fromJson(json['picture']['data']);
  }
}

class FacebookPhotoModel {
  String? url;
  int? height;
  int? width;

  FacebookPhotoModel({this.height, this.width, this.url});

  FacebookPhotoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }
}
