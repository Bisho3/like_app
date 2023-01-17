class CreateUser{
   String? email;
   String? address;
   String? city;
   String? area;
   String? location;
   String? name;
   String? uId;
   String? phoneNumber;

   CreateUser({
     required this.name,
     required this.email,
     required this.location,
     required this.city,
     required this.area,
     required this.uId,
     required this.address,
     required this.phoneNumber
});
  CreateUser.fromJson(Map<String, dynamic>json){
    name = json['name'];
    email = json['email'];
    location = json['location'];
    city =json['city'];
    area = json['area'];
    uId = json['uId'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'email':email,
      'location':location,
      'city':city,
      'area':area,
      'uId':uId,
      'address':address,
      'phoneNumber':phoneNumber
    };
  }
}