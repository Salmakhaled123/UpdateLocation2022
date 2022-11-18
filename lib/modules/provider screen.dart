import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mymap/components/components.dart';
import 'package:mymap/cubit/cubit.dart';
import 'package:mymap/cubit/states.dart';

import 'mapScreen.dart';

class ProviderScreen extends StatelessWidget {
  var scaffoldKey2 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LocationCubit.get(context);
        double mediaHeight = MediaQuery.of(context).size.height;
        double mediaWidth = MediaQuery.of(context).size.height;
        return Scaffold(
          key: scaffoldKey2,
          drawer: Drawer(
              child: Column(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  accountName: Text('admin'),
                  accountEmail: Text('admin@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Text(
                      'A',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                    ),
                  )),
              buildDrawerItem(cubit.screensByDrawer, cubit.drawerIcons, context),
              SizedBox(
                height: mediaHeight * 0.003,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal)),
                    child: Text('user mode')),
              )
            ],
          )),
          body: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                height: mediaHeight,
                width: mediaWidth,
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(30.033333, 31.233334),
                    zoom: 12.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    cubit.mapController = controller;
                  },
                  markers: cubit.markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                    onPressed: ()
                    {
                      scaffoldKey2.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu)),
              )
            ],
          ),
        );
      },
    );
  }
}
