import 'package:flutter/material.dart';
import 'package:mach_managed/user/brain_waise/filter_bottom_sheet.dart';


class SessionsList extends StatelessWidget {
  const SessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
         // padding: const EdgeInsets.symmetric(horizontal: 20),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Browse"),
            Row(
              children: [
                Expanded(child: TextFormField()),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FilterBottomSheetExample()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.display_settings_rounded),
                  ),
                ),
              ],
            ),

            ChipWrapExample(),
            Expanded(child: Sessions()),


          ],
        ),
      ),
    );
  }
}

class Sessions extends StatelessWidget {
   Sessions({super.key});
  final List<String> imageUrls = [
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',

    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',

    'https://images.unsplash.com/photo-1534826249391-131b0b415668?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',

    'https://images.unsplash.com/photo-1534826249391-131b0b415668?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://img.freepik.com/free-photo/photorealistic-view-tree-nature-with-branches-trunk_23-2151478038.jpg?t=st=1728281752~exp=1728285352~hmac=7fceebe97a9e514fb109960b9dfa67ed4d10e81dab19cd850412c3bdfd37440e&w=740',
    'https://images.unsplash.com/photo-1534826249391-131b0b415668?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1534826249391-131b0b415668?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display 3 columns
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Session(image: imageUrls[index],);
      },
      padding: const EdgeInsets.all(20),
    );
  }
}



class Session extends StatelessWidget {
 String? image;
 Session({super.key,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.cyanAccent,
        image: DecorationImage(
          image: NetworkImage(image?? 'https://via.placeholder.com/300'),
      fit: BoxFit.cover,
    ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text("data")),
            Text("data"),
            Text("data"),
          ],
        ),
      ),
    );
  }
}




class ChipWrapExample extends StatefulWidget {
  @override
  State<ChipWrapExample> createState() => _ChipWrapExampleState();
}

class _ChipWrapExampleState extends State<ChipWrapExample> {
  final List<String> _choices = ["All","Flutter", "Dart", "Firebase", "Android","Flutter", "Dart", "Firebase", "Android"];

  String _selectedChoice = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
       scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10,right: 10),

        children: _choices.map((choice) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              backgroundColor: const Color(0xFFE1E4F3),
              padding: const EdgeInsets.symmetric(horizontal: 15),

              side: BorderSide.none,
              selectedColor: Colors.blueAccent,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              showCheckmark: false,
              label: Text(choice),
              selected: _selectedChoice == choice,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChoice = selected ? choice : "";
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}