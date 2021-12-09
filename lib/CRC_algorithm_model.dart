// ignore: file_names
int CRC(String number, String divisor) {

  return 1;
  /*
  List data = List.filled(number.length, null, growable: false);
  data = number.split("");
  return int.parse(data[0].toString()) + int.parse(divisor[0].toString()) ;

   */
}
/*
  int size;
  List data = List.filled(number.length, null, growable: false);
  data = number.split("");
  print("data ${data}");

  List divisor_list = List.filled(divisor.length, null, growable: false);
  divisor_list = divisor.split("");
  print("divisor ${divisor}");

  List rem = divideDataWithDivisor(data, divisor_list);

  for(int i = 0; i < rem.length-1; i++) {
    print(rem[i]);
  }
  print("\nGenerated CRC code is: ");

  for(int i = 0; i < data.length; i++) {
    print(data[i]);
  }
  for(int i = 0; i < rem.length-1; i++) {
    print(rem[i]);
  }
  return "0";
}

List<int> divideDataWithDivisor(List oldData, List divisor) {
  // declare remainder array
  List<int> rem = List.filled(divisor.length, null, growable: true) as List<int>;
  int i;
  List data = List.filled(oldData.length + divisor.length, null, growable: true);
  data = List.from(oldData)  as List<int>;
  rem = List.from(data)  as List<int>;

  for(i = 0; i < oldData.length; i++) {
    print("${i+1}{.) First data bit is : } {$rem[0]}");
    print("Remainder : ");

    if(rem[0] == 1) {

      // We have to xor the remainder bits with divisor bits
      for(int j = 1; j < divisor.length; j++) {
        rem[j-1] =xorOperation(rem[j], divisor[j]);
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


// XOR Operation
int xorOperation(int x, int y) {
// This simple function returns the exor of two bits
if(x == y) {
return 0;
}
return 1;
}
*/