class CheckoutUser {
  final String name;
  final String email;
  final String tickets;

  CheckoutUser({
    this.name,
    this.email,
    this.tickets,
  });
  CheckoutUser.fromData(Map<String, dynamic> data)
      : name = data['name'],
        email = data['email'],
        tickets = data['tickets'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'tickets': tickets,
    };
  }
}
