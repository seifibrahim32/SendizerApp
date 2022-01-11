
import 'package:flutter/material.dart';

void CRC(String text, String? div,BuildContext context) {
  print('ASCII value of ${text[0]} is ${text.codeUnits[0]}');
  List<String> binarys = text.codeUnits.map((int strInt) =>
      strInt.toRadixString(2)).toList();
  print(binarys);

  String formatted_binary_data = "";
  binarys.forEach((element) {
    formatted_binary_data = formatted_binary_data + element;
  });
  print(formatted_binary_data.split(""));
  print(num.parse(formatted_binary_data[2]));
  print('ASCII value of ${text[1]} is ${text.codeUnits[1]}');

  // declare n for the size of the data
  int size = formatted_binary_data.length;
  // declaration of the data array
  List<int> data = List.filled(size, 0,
      growable: false);

  for (int i = 0; i < size; i++) {
    data[i] = int.parse(formatted_binary_data[i]);
    print("Bit ${size - i} : ${data[i]}");
  }
  // take the size of the divisor from the user
  size = div!.length;
  print("Size of the divisor array: $size ");
  // declaration of the divisor array
  List<int> divisor = List.filled(size, 0,
      growable: false);
  print("Divisor bits in list: \n");
  for (int i = 0; i < divisor.length; i++) {
    divisor[i] = int.parse(div[i]);
    print("\nBit ${size - i}: ${divisor[i]}");
  }
  // Divide the input data by the input divisor and store the result in the rem array
  List<int> rem = divideDataWithDivisor(data,
      divisor);
  // iterate rem using for loop to print each bit
  for (int i = 0; i < rem.length - 1; i++) {
    print(rem[i]);
  }
  print("\nGenerated CRC code is: ");

  for (int i = 0; i < data.length; i++) {
    print(data[i]);
  }
  for (int i = 0; i < rem.length - 1; i++) {
    print(rem[i]);
  }
  WidgetsBinding.instance?.addPostFrameCallback((_){


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data} ${rem}')));
  });
  print("\n");
  // we create a new array that contains the original data with its CRC code
  // the size of the sentData array with be equal to the sum of the data and the rem arrays length
  List<int> sentData = List.filled(
      data.length + rem.length - 1, 0, growable: false);
  print("Bits you send: \n");
  for (int i = 0; i < sentData.length; i++) {
    sentData[i] = 1;
    print("Bit ${(sentData.length - i)}: ${sentData[i]}");
  }
  receiveData(sentData, divisor);

}
// method to print received data
void receiveData(List<int> data,List<int> divisor) {
  List<int> rem = divideDataWithDivisor(data, divisor);
  // Division is done
  for(int i = 0; i < rem.length; i++) {
    if(rem[i] != 0) {
      // if the remainder is not equal to zero, data is corrupted
      print("Corrupted data received...\n");
      return;
    }
  }
  print("Data received without any error.\n");
}


// create divideDataWithDivisor() method to get CRC
List<int> divideDataWithDivisor(List<int> oldData, List<int> divisor) {

  List<int> data = List<int>.filled(oldData.length + divisor.length , 0,growable: false);
  print(data);

  List<int> rem = List<int>.filled(divisor.length , 0,growable: false);

  int i;
  for(i = 0 ; i < divisor.length; i++){
    rem[i] = data[i];
  }
  print("\n");
  for(i = 0 ; i < oldData.length ; i++){
    data[i] = oldData[i];
  }
  print(data);
  rem = List.from(data);
  print(rem);

  // iterate the oldData and exor the bits of the remainder and the divisor
  for(i = 0; i < oldData.length ; i++) {
    print("${(i+1)}.) First data bit is : ${ rem[0]}");
    print("\n");
    print("Remainder : ");
    if(rem[0] == 1) {
      // We have to xor the remainder bits with divisor bits
      for(int j = 1; j < divisor.length; j++) {
        rem[j-1] = xorOperation(rem[j], divisor[j]);
        print(rem[j-1]);
      }
    }
    else {
      // We have to xor the remainder bits with 0
      for(int j = 1; j < divisor.length; j++) {
        rem[j-1] = xorOperation(rem[j], 0);
        print(rem[j-1]);
      }
    }
    // The last bit of the remainder will be taken from the data
    // This is the 'carry' taken from the dividend after every step
    // of division
    rem[divisor.length-1] = data[i+divisor.length];
    print(rem[divisor.length-1]);
  }
  return rem;
}
// create xorOperation() method to perform exor data
int xorOperation(int x, int y) {
  // This simple function returns the exor of two bits
  if(x == y) {
    return 0;
  }
  return 1;
}





//-------------------------------------------

void myCRC(String text, String? div,BuildContext context) {
  print('ASCII value of ${text[0]} is ${text.codeUnits[0]}');
  List<String> binarys = text.codeUnits.map((int strInt) =>
      strInt.toRadixString(2)).toList();
  print(binarys);

  String formatted_binary_data = "";
  binarys.forEach((element) {
    formatted_binary_data = formatted_binary_data + element;
  });
  print(formatted_binary_data.split(""));
  print(num.parse(formatted_binary_data[2]));
  print('ASCII value of ${text[1]} is ${text.codeUnits[1]}');

  // declare n for the size of the data
  int size = formatted_binary_data.length;
  // declaration of the data array
  List<int> data = List.filled(size, 0,
      growable: false);

  for (int i = 0; i < size; i++) {
    data[i] = int.parse(formatted_binary_data[i]);
    print("Bit ${size - i} : ${data[i]}");
  }
  // take the size of the divisor from the user
  size = div!.length;
  print("Size of the divisor array: $size ");
  // declaration of the divisor array
  List<int> divisor = List.filled(size, 0,
      growable: false);
  print("Divisor bits in list: \n");
  for (int i = 0; i < divisor.length; i++) {
    divisor[i] = int.parse(div[i]);
    print("\nBit ${size - i}: ${divisor[i]}");
  }
  // Divide the input data by the input divisor and store the result in the rem array
  List<int> rem = divideDataWithDivisor(data,
      divisor);
  // iterate rem using for loop to print each bit
  for (int i = 0; i < rem.length - 1; i++) {
    print(rem[i]);
  }
  print("\nGenerated CRC code is: ");

  for (int i = 0; i < data.length; i++) {
    print(data[i]);
  }
  for (int i = 0; i < rem.length - 1; i++) {
    print(rem[i]);
  }
  WidgetsBinding.instance?.addPostFrameCallback((_){


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data} ${rem}')));
  });
  print("\n");
  // we create a new array that contains the original data with its CRC code
  // the size of the sentData array with be equal to the sum of the data and the rem arrays length
  List<int> sentData = List.filled(
      data.length + rem.length - 1, 0, growable: false);
  print("Bits you send: \n");
  for (int i = 0; i < sentData.length; i++) {
    sentData[i] = 1;
    print("Bit ${(sentData.length - i)}: ${sentData[i]}");
  }
  receiveData(sentData, divisor);
}