import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gojo_renthub/views/shared/components/models/House.dart';

class Details extends StatefulWidget {
  Details({super.key, required this.house});

  House house;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool showFullText = false;
  @override
  Widget build(BuildContext context) {
    String longText =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer euismod tempor arcu, ac viverra mauris vestibulum nec. Phasellus et neque ut libero consequat vehicula ac non quam. Duis vestibulum, nisi sit amet rhoncus congue, lacus ligula iaculis elit, eu efficitur tortor odio vel velit. Phasellus faucibus euismod neque, vitae convallis massa bibendum eu.";

    String displayedText = showFullText ? longText : longText.substring(0, 50);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Center(
                    child: Container(
                      width: 350,
                      height: 310,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(widget.house.houseImage, 
                        fit: BoxFit.cover,)),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(210, 222, 222, 223),
                          foregroundColor:
                              const Color.fromARGB(158, 95, 94, 94),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(1),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(220, 222, 222, 223),
                          foregroundColor:
                              const Color.fromARGB(158, 95, 94, 94),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(1),
                        ),
                        child: Icon(Icons.bookmark),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: displayedText,
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    if (!showFullText)
                      TextSpan(
                        text: '... see more',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              showFullText = true;
                            });
                          },
                      ),
                  ],
                ),
              )
            ],
          ),
          const Card(
            elevation: 0,
            child: ListTile(

              leading: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 29,
                  backgroundImage: AssetImage('Assets/images/nike.jpg'),
                ),
              ),
              title: Text('Susan lee'),
              subtitle: Text('This is the body'),
            ),
          ),
          Text("Gallery"),
          Container(
            width: double.infinity,
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 110,
                  child: Padding(
                    
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Assets/images/house.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 70,),

           Padding(
             padding: const EdgeInsets.all(4.0),
             child: Row(
              children: [
                const Text("Birr 2,500/year", style: TextStyle(fontSize: 30)),
                const Spacer(),
                ElevatedButton(onPressed: (){}, 
                 style:  ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), 
                ),),
                  minimumSize: MaterialStateProperty.all(Size(50, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                 ),
                 child: const Text("Rent Now"),)
           
              ],
                     ),
           )
        ],
      ),
    );
  }
}
