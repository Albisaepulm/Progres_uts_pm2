import 'dart:ui';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Daftar produk toko
  final List<Map<String, String>> _products = [
    {'name': 'Produk A', 'price': 'Rp 100.000', 'image': 'assets/product_1.jpg'},
    {'name': 'Produk B', 'price': 'Rp 200.000', 'image': 'assets/product_2.jpg'},
    {'name': 'Produk C', 'price': 'Rp 150.000', 'image': 'assets/product_3.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
        elevation: 10, // Memberikan bayangan pada app bar
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // Halaman pertama dengan background blur (Home Page)
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/store_background.jpg'), // Gambar latar belakang toko
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Membuat sudut gambar lebih melengkung
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Efek blur pada background
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Efek gelap di atas gambar
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Selamat datang di Toko Kami!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Tambahkan jumlah pesanan:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Menu kedua: Daftar Produk
            ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Image.asset(_products[index]['image']!, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(_products[index]['name']!),
                    subtitle: Text(_products[index]['price']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$_counter produk ditambahkan ke keranjang!')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            // Menu ketiga: Settings (Pengaturan)
            const Center(child: Text('Pengaturan Toko')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.orange, 
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
