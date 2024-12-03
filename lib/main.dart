import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Eliminarea bannerului de debug
      home: SpecialistDoctorScreen(),// Ecranul principal al aplicației
    );
  }
}

class SpecialistDoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Eliminarea umbrei
        toolbarHeight: 80, // Mărirea înălțimii barei de instrumente
        title: Column( //vertical
          children: [
            Row( //orizontal
              children: [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 5),
                Text("Seattle, USA",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10), // Spațiu
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                hintText: "Search doctor...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner section
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/images/1.png'), // Imaginea 1.png
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack( //suprapunere
                children: [
                  Positioned(
                    top: 10,
                    left: 16,
                    child: Text(
                      "Looking for\nSpecialist Doctors?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 16,
                    child: Text(
                      "Schedule an appointment with our top doctors.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("See All"),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Grid of categories
            GridView.count( //specisfica cate coloane sunt in grila
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, //aspect ajustat
              physics: NeverScrollableScrollPhysics(), //pentru derulare
              children: categories.map((category) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: category.icon != null
                          ? Icon(category.icon, size: 30, color: Colors.white)
                          : Image.asset(
                        category.imagePath!,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      category.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // Nearby Medical Centers Section
            Text(
              "Nearby Medical Centers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 180, // Înălțimea containerului modificată
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: medicalCenters.map((center) {
                  return _buildMedicalCenterCard(center);
                }).toList(),
              ),
            ),

            SizedBox(height: 20),

            // Doctor List Section
            Text(
              "532 found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              children: doctors.map((doctor) {
                return _buildDoctorCard(doctor);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalCenterCard(MedicalCenter center) {
    return Card(
      margin: const EdgeInsets.only(right: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Border radius ajustat
      ),
      child: Container(
        width: 232, // Lățimea card-ului
        height: 180, // Înălțimea card-ului
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  center.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              center.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(center.address),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 14),
                SizedBox(width: 2),
                Text('${center.rating}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(doctor.imageUrl),
        ),
        title: Text(
          doctor.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.specialization),
            Text(doctor.clinic),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber),
            Text('${doctor.rating}'),
            Text('${doctor.reviews} Reviews'),
          ],
        ),
      ),
    );
  }
}

// Definirea claselor
class MedicalCenter {
  final String name; //variabila
  final String address;
  final double rating;
  final String imageUrl;

  MedicalCenter({
    required this.name, //valori
    required this.address,
    required this.rating,
    required this.imageUrl,
  });
}

List<MedicalCenter> medicalCenters = [
  MedicalCenter(
    name: 'Sunrise Health Clinic',
    address: '123 Oak Street, CA 98765',
    rating: 5.0,
    imageUrl: 'assets/images/2.jpeg',
  ),
  MedicalCenter(
    name: 'Golden Cardiology',
    address: '555 Bridge Street, CA',
    rating: 4.9,
    imageUrl: 'assets/images/3.jpeg',
  ),
];

// Definition of Doctor class
class Doctor {
  final String name;
  final String specialization;
  final String clinic;
  final double rating;
  final int reviews;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialization,
    required this.clinic,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });
}

// Lista doctori
List<Doctor> doctors = [
  Doctor(
    name: 'Dr. David Patel',
    specialization: 'Cardiologist',
    clinic: 'Cardiology Center, USA',
    rating: 5.0,
    reviews: 1872,
    imageUrl: 'assets/images/4.png',
  ),
  Doctor(
    name: 'Dr. Jessica Turner',
    specialization: 'Gynecologist',
    clinic: 'Women\'s Clinic, Seattle, USA',
    rating: 4.9,
    reviews: 127,
    imageUrl: 'assets/images/5.png',
  ),
  Doctor(
    name: 'Dr. Michael Johnson',
    specialization: 'Orthopedic Surgery',
    clinic: 'Maple Associates, NY, USA',
    rating: 4.7,
    reviews: 5223,
    imageUrl: 'assets/images/6.png',
  ),
  Doctor(
    name: 'Dr. Emily Nguyen',
    specialization: 'Neurologist',
    clinic: 'Neurology Clinic, LA, USA',
    rating: 4.6,
    reviews: 321,
    imageUrl: 'assets/images/7.png',
  ),
];


// Definirea  categoriilor
class Category {
  final String label;
  final Color color;
  final IconData? icon;
  final String? imagePath;

  Category({
    this.imagePath,
    required this.label,
    required this.color,
    this.icon,
  });
}

// lista categoriile
List<Category> categories = [
  Category(imagePath: 'assets/images/i1.png', label: 'Dentistry', color: Color(0xFFDC9497)),
  Category(imagePath: 'assets/images/i2.png', label: 'Cardiology', color: Color(0xFF93C19E)),
  Category(imagePath: 'assets/images/i3.png', label: 'Pulmonology', color: Color(0xFFF5AD7E)),
  Category(imagePath: 'assets/images/i4.png', label: 'General', color: Color(0xFFACA1CD)),
  Category(imagePath: 'assets/images/i5.png', label: 'Neurology', color: Color(0xFF4D9B91)),
  Category(imagePath: 'assets/images/i6.png', label: 'Gastroenter..', color: Color(0xFF352261)),
  Category(icon: Icons.biotech, label: 'Laboratory', color: Color(0xFFDEB6B5)),
  Category(imagePath: 'assets/images/i8.png', label: 'Vaccination', color: Color(0xFFACA1CD)),
];