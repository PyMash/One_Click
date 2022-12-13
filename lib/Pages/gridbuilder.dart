import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'address_page.dart';
import 'service.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Service> services = [
    Service('10.00AM'),
    Service('11.00AM'),
    Service('12.00AM'),
    Service('01:00PM'),
    Service('02.00PM'),
    Service(
      '03.00PM',
    )
  ];

  int selectedService = -1;
  DateTime today = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: selectedService >= 0
          ? FloatingActionButton(
              onPressed: () {
                debugPrint(selectedService.toString());
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddressPage()));
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              backgroundColor: Colors.deepPurple,
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(25.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return serviceContainer( services[index].name, index);
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  serviceContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else
            selectedService = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.deepPurple
                : Colors.deepPurple.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(image, height: 80),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}
