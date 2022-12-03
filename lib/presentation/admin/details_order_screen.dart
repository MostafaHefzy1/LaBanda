import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/admin_logic/cubit.dart';
import 'package:labanda/business_logic/admin_logic/states.dart';
import 'package:labanda/data/model/cart_product.dart';
import 'package:labanda/presentation/admin/store.dart';

class DetailsOrder extends StatelessWidget {
  Store store = Store();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: store.loadOrderDetails(AdminCubit.get(context).ID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.docs) {
                    AdminCubit.get(context).products.add(CartModel(
                      name: doc.get('name'),
                      price: doc.get('price'),
                      quatity: doc.get('Quantity'),
                    ));
                  }

                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .2,
                              color: Colors.grey[300],
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        'product name : ${AdminCubit.get(context).products[index].name}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Quantity : ${AdminCubit.get(context).products[index].quatity}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Price : ${AdminCubit.get(context).products[index].price}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          itemCount:AdminCubit.get(context). products.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Loading Order Details'),
                  );
                }
              }),
        );
      },
    );
  }
}
