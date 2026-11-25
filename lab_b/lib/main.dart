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

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Original order, never modified. Used to restore order on Reset Sort.
  final List<Car> _originalCars = [
    Car(make: 'Toyota', model: 'Vios', price: 89600),
    Car(make: 'Perodua', model: 'Myvi', price: 59900),
    Car(make: 'Honda', model: 'City', price: 84900),
    Car(make: 'Proton', model: 'X50', price: 86300),
    Car(make: 'Mazda', model: 'CX-5', price: 144469),
  ];

  // Working list that gets sorted in place.
  late final List<Car> _cars = List.of(_originalCars);

  // Cars matching the search query (keeps the current sort order).
  List<Car> get _filteredCars {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return _cars;
    return _cars.where((car) {
      return car.make.toLowerCase().contains(query) ||
          car.model.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  void _resetSort() {
    if (_sortColumnIndex == null) return;
    setState(() {
      _sortColumnIndex = null;
      _sortAscending = true;
      _cars
        ..clear()
        ..addAll(_originalCars);
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedCars = _filteredCars;
    return Scaffold(
      appBar: AppBar(title: const Text('Lab B: Car Price DataTable')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by make or model',
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                      suffixIcon: _searchQuery.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              tooltip: 'Clear search',
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            ),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _resetSort,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset Sort'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
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
                  rows: displayedCars.map((car) {
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
            ),
          ),
          if (displayedCars.isEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text('No cars match your search.'),
            ),
        ],
      ),
    );
  }
}
