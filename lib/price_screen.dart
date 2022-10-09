

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String  selectedCurrency = 'KES';
  List<DropdownMenuItem> getDropdownItems (){
    List<DropdownMenuItem<String>> DropdownItems = [];
    for (String currency in currenciesList){
     var newItem = DropdownMenuItem(
  child: Text(currency),
  value: currency,
);
    DropdownItems.add(newItem);
    }
    return  DropdownItems;
  }

  List<Widget> getPickerItems() {
    List<Text> pickerItems =[];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
      Text(currency);
    }
    return pickerItems;

  }
  @override
  Widget build(BuildContext context) {
    getDropdownItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlue,
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex){
                print(selectedIndex);
              },
              children:getPickerItems(),

            ),
          ),
        ],
      ),
    );
  }
}
// DropdownButton(
// value: selectedCurrency,
// items: getDropdownItems(),
// onChanged: ((value) {
// setState(() {
// selectedCurrency = value!;
// });
// print(value);
// }),),