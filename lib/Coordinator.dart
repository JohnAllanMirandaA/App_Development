class Coordinator {
  final String companyName;
  final String contactNumber;
  final String serviceType;

  Coordinator({
    required this.companyName,
    required this.contactNumber,
    required this.serviceType,
  });
  Map<String, dynamic> toJson() {
  return {
    'companyName': companyName,
    'contactNumber': contactNumber,
    'serviceType': serviceType,
  };
}


  factory Coordinator.fromJson(Map<String, dynamic> json) {
    return Coordinator(
      companyName: json['companyName'],
      contactNumber: json['contactNumber'],
      serviceType: json['serviceType'],
    );
  }
}// Booking Details Page
