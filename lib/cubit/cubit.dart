import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mymap/cubit/states.dart';

class LocationCubit extends Cubit<LocationStates> {
 LocationCubit() : super(LocationInitialState());

 static LocationCubit get(context) => BlocProvider.of(context);
GoogleMapController ?mapController;

 Future getPermission() async
 {
  bool services;
  LocationPermission locationPermission;
  services = await Geolocator.isLocationServiceEnabled();
  print(services);
  locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.denied) {
   locationPermission = await Geolocator.requestPermission();
  }
  if (locationPermission == LocationPermission.always) {
   emit(GetPositionSuccess());
  }
 }

 var currentLocation;
 var lat;
 var lang;
 Set<Marker> markers={};

 void getLatAndLong() {
  currentLocation = Geolocator.getCurrentPosition().then((value) {
   lat = value.latitude;
   lang = value.longitude;
   print(lat);
   print(lang);
   LatLng lng=LatLng(lat, lang);
  markers={ Marker(markerId: MarkerId('1'),position:LatLng(lat,lang) )};
  mapController?.animateCamera(CameraUpdate.newLatLng(lng));
   // List<Placemark> placeMarks = await placemarkFromCoordinates(value.latitude,value.longitude);
   // print(placeMarks[0].country);
   // print(placeMarks[0].administrativeArea);
   // print(placeMarks[0].locality);
   emit(GetCurrentLocationSuccess());
  }).catchError((error) {
   emit(GetCurrentLocationError(error.toString()));
  });
 }
 List <String> screensByDrawer=
 [
  'Home page',
  'Settings',
  'Language',

 ];
 List<IconData> drawerIcons=
 [
  Icons.home,
  Icons.miscellaneous_services,
  Icons.language,

 ];
 Widget buildDrawer()=>Drawer(
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       UserAccountsDrawerHeader(
           decoration: BoxDecoration(color: Colors.teal),
           accountName: Text('admin'),
           accountEmail: Text('admin@gmail.com'),
           currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.pink,
            child: Text(
             'A',
             style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
                 color: Colors.white),
            ),
           )),
       // buildDrawerItem(
       //     cubit.screensByDrawer, cubit.drawerIcons, context),
       // Center(
       //   child: ElevatedButton(
       //       onPressed: () {
       //         Navigator.push(
       //             context,
       //             MaterialPageRoute(
       //                 builder: (context) => ProviderScreen()));
       //       },
       //       style: ButtonStyle(
       //           backgroundColor:
       //           MaterialStateProperty.all(Colors.teal)),
       //       child: Text('Provider mode')),
       // )
      ],
     ));

}