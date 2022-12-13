import 'package:flutter/material.dart';

import 'Payment_page.dart';
import 'service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ServiceTwo> services = [
    ServiceTwo('Tutor', 'img_file/Tutor.png'),
    ServiceTwo('Electrician', 'img_file/Electrician.png'),
    ServiceTwo('Plumber', 'img_file/Plumber.png'),
    ServiceTwo('Mechanic', 'img_file/Mechanic.png'),
    ServiceTwo('Assistance', 'img_file/Assistance.png'),
    ServiceTwo(
      'Driver',
      'img_file/Driver.png',
    )
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: selectedService >= 0
          ? FloatingActionButton(
              onPressed: () async{
                outcome(number) {
                  if (number == 0) {
                    return "Tutor";
                  } else if (number == 1) {
                    return "Electrician";
                  } else if (number == 2) {
                    return "Plumber";
                  } else if (number == 3) {
                    return "Mechanic";
                  } else if (number == 4) {
                    return "Assistance";
                  } else if (number == 5) {
                    return "Driver";
                  }
                }

                String? service = outcome(selectedService);
                String ns = service!;
                debugPrint(service);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentPage(
                              service: service,
                            )));
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              backgroundColor: Color.fromARGB(255, 82, 25, 180),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Which Service',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 82, 25, 180),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'do you required ?',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 82, 25, 180),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(25.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return serviceContainer(services[index].imageURL,
                            services[index].name, index);
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
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
                ? Color.fromARGB(255, 82, 25, 180)
                : Color.fromARGB(255, 82, 25, 180).withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(image, height: 80),
              Image.asset(
                image,
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}
