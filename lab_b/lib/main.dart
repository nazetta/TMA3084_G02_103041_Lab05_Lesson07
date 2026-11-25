import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Car {
  final String make;
  final String model;
  final int price;

  Car({required this.make, required this.model, required this.price});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab B - Sortable DataTable',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CarTablePage(),
    );
  }
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final List<Car> _cars = [
    Car(make: 'Toyota', model: 'Vios', price: 89600),
    Car(make: 'Perodua', model: 'Myvi', price: 59900),
    Car(make: 'Honda', model: 'City', price: 84900),
    Car(make: 'Proton', model: 'X50', price: 86300),
    Car(make: 'Mazda', model: 'CX-5', price: 144469),
  ];

  void _sort<T extends Comparable<T>>(
    T Function(Car car) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _cars.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab B: Car List (Main)')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (columnIndex, ascending) =>
                  _sort((car) => car.make, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('Model'),
              onSort: (columnIndex, ascending) =>
                  _sort((car) => car.model, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('Price (RM)'),
              numeric: true,
              onSort: (columnIndex, ascending) =>
                  _sort((car) => car.price, columnIndex, ascending),
            ),
          ],
          rows: _cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model)),
                DataCell(Text(car.price.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
