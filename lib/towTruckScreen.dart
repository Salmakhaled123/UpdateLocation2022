import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mymap/cubit/cubit.dart';
import 'package:mymap/cubit/states.dart';
import 'components/components.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LocationCubit.get(context);
        var searchController = TextEditingController();
        double mediaHeight=MediaQuery.of(context).size.height;
        double mediaWidth=MediaQuery.of(context).size.height;

        return Scaffold(

          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SizedBox(
                height: mediaHeight,
                width: mediaWidth,
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: const CameraPosition(
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
                padding: const EdgeInsets.only(top: 35, right:15, left: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    defaultFormField(
                      label: 'Search Places',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      isPassword: false,
                      controller: searchController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'search musn\' t be empty';
                        }
                      },
                    ),
                    SizedBox(height: mediaHeight*0.5,),
                    InkWell(onTap: ()async
                    {
                      cubit.getPosition();
                      cubit.getLatAndLong();
                    },
                        child: const CircleAvatar(backgroundColor: Colors.teal,
                          radius:20,child: Icon(
                              Icons.location_searching,color: Colors.white),))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 5.0) ,
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_upward_outlined),
                            SizedBox( width: 5,),
                            Text('Select the type of service',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),//bottomSheet
            ],
          ),
        );
      },
    );
  }
}

