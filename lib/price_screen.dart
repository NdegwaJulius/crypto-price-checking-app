

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String  selectedCurrency = 'KES';

  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>> DropdownItems = [];
    for (String currency in currenciesList){
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      DropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: DropdownItems ,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;

      });
  },
    );
  }

  CupertinoPicker iOSPicker (){
    List<Text> pickerItems =[];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
      Text(currency);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
      },
      children:pickerItems,

    );
  }




 //  getPicker() {
 //    if(Platform.isIOS) {
 //      return iOSPicker();
 //    } else if (Platform.isAndroid) {
 //      return  androidDropdown();
 //    }
 //
 // }
  @override
  Widget build(BuildContext context) {

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
            child: Platform.isIOS ? iOSPicker() :androidDropdown()
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