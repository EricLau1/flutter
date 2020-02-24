class Contact {
  int id;
  String name;
  String email;
  String image;

  Contact({this.id, this.name, this.email, this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    image = map['image'];
  }

  @override
  String toString() {
    return "Contact{ id: $id, name: $name, email: $email, image: $image }";
  }
}