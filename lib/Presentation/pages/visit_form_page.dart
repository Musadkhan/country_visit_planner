import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/visited_country_model.dart';
import '../controller/visited_controller.dart';

class VisitFormPage extends StatefulWidget {
  final String countryName;
  final String flagUrl;
  final String region;
  final int population;

  const VisitFormPage({super.key, required this.countryName, required this.flagUrl,required this.region, required this.population});

  @override
  State<VisitFormPage> createState() => _VisitFormPageState();
}

class _VisitFormPageState extends State<VisitFormPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _visitedPlacesController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  String _selectedCurrency = "₹";
  double _satisfaction = 3;

  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        isStart ? _startDate = picked : _endDate = picked;
      });
    }
  }

  void _saveVisit() {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      final visit = VisitedCountryModel(
        name: widget.countryName,
        flagUrl: widget.flagUrl,
        startDate: _startDate!,
        endDate: _endDate!,
        visitedPlaces: _visitedPlacesController.text,
        cost: double.tryParse(_costController.text) ?? 0,
        satisfactionScore: _satisfaction.toInt(),
        currency: '',
        region: widget.region,
        population: widget.population.toInt()
      );

      Provider.of<VisitedController>(context, listen: false).addVisit(visit);
      Navigator.pop(context); // Go back to detail screen
    }
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null ? label : '${date.day}/${date.month}/${date.year}',
              style: TextStyle(
                fontSize: 16,
                color: date == null ? Colors.grey : Colors.black,
              ),
            ),
            const Icon(Icons.calendar_month, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visit to ${widget.countryName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Country visited form",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
              SizedBox(height: 10),
              Text("Please add all information in below form to save your visit to ${widget.countryName}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center),

              SizedBox(height: 25),

              _buildDatePicker(
                label: 'Select Start Date',
                date: _startDate,
                onTap: () => _pickDate(true),
              ),
              _buildDatePicker(
                label: 'Select End Date',
                date: _endDate,
                onTap: () => _pickDate(false),
              ),


              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextFormField(
                    controller: _visitedPlacesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'What Did You Visit?',
                      border: InputBorder.none,
                    ),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                      items: ['₹', '\$', '€', '£'].map((symbol) {
                        return DropdownMenuItem(
                          value: symbol,
                          child: Text(symbol, style: TextStyle(fontSize: 18)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _costController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Total Cost',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),
              Text("Satisfaction Score: ${_satisfaction.toInt()}",style: TextStyle(fontSize: 18)),
              Slider(
                value: _satisfaction,
                onChanged: (val) => setState(() => _satisfaction = val),
                min: 1,
                max: 5,
                divisions: 4,
                activeColor: Colors.green,
                label: _satisfaction.toInt().toString(),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _saveVisit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Visit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}