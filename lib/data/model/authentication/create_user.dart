class CreateUser{
   String? email;
   String? address;
   String? city;
   String? area;
   String? location;
   String? name;
   String? uId;
   String? phoneNumber;
   String? coverImage;
   String? profileImage;
   String? bio;
   bool? byEmail = false;


   CreateUser({
     required this.name,
     required this.email,
     required this.location,
     required this.city,
     required this.area,
     required this.uId,
     required this.address,
     required this.phoneNumber,
     required this.profileImage,
     required this.coverImage,
     required this.bio,
     required this.byEmail
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
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    byEmail = json['byEmail'];
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
      'phoneNumber':phoneNumber,
      'profileImage': profileImage,
      'coverImage':coverImage,
      'bio':bio,
      'byEmail':byEmail
    };
  }
}