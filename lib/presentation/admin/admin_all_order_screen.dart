import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/admin_logic/cubit.dart';
import 'package:labanda/business_logic/admin_logic/states.dart';
import 'package:labanda/presentation/admin/store.dart';

import '../../data/model/order_model.dart';
import '../resources/routes_manager.dart';

class OrdersScreen extends StatelessWidget {
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadOrders(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('there is no orders'),
                );
              } else {
                List<OrderModel> orders = [];
                for (var doc in snapshot.data!.docs) {
                  orders.add(OrderModel(
                    documentId: doc.id,
                    address: doc.get('address'),
                    phone: doc.get('phone'),
                    name: doc.get('title'),
                    latitude: doc.get('latitude'),
                    longitude: doc.get('longitude'),
                    price: doc.get('price'),
                  ));
                }
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.detailsScreen,
                            arguments: orders[index].documentId);
                        AdminCubit.get(context).ID = orders[index].documentId!;
                      },
                      child: Container(
                        height: 350,
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Name is ${orders[index].name}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Address  ${orders[index].address}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Phone  ${orders[index].phone}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Total Price =   ${orders[index].price}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children:
                                [
                                  TextButton(
                                      onPressed: () {
                                        double? latuide = orders[index].latitude;
                                        double? longtuide = orders[index].longitude;

                                        AdminCubit.get(context)
                                            .goToMaps(latuide!, longtuide!);
                                      },
                                      child: Text(
                                        'Go To Location',
                                      )),
                                  Spacer() ,
                                  TextButton(
                                      onPressed: ()
                                      {
                                        AdminCubit.get(context).deleteOrder(orders[index].documentId!) ;
                                      },
                                      child: Text(
                                        'DELETE ORDER',
                                        style: TextStyle(
                                          color: Colors.red ,
                                        ),
                                      )  ,
                                  ),


                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: orders.length,
                );
              }
            },
          ),
        );
      },
    );
  }
}
