class ContactModel {
  String name;
  String email;
  String phone;
  String message;

  ContactModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  // Factory method to create a ContactModel from JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      message: json['message'],
    );
  }

  // Method to convert ContactModel to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'message': message};
  }
}
