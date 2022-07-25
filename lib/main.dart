import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wakelock/wakelock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget 
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1)
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



//Homescreen
class MyHomePage extends StatefulWidget 
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{

  String aDescription = "Program A runs constantly until the user stops the program, with a reholster command and countdown between commands. Enter the par time, split time, delay time (min and max), number of shots per iteration, number of rounds, reholster time, and command options.";
  String bDescription = "Program B runs one iteration at a time. User enters all of the same options with the exception of reholster time. The user will push the start button each time they want the program to run.";

  // ignore: prefer_typing_uninitialized_variables
  bool boolVal = true;

  @override
  void initState() 
  {
    super.initState();
  }

  Future<bool> fetchData() async
  {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTimeOpened = prefs.getBool('isFrstOpened') ?? true;
    final bool valueBool = await Future<bool>.value(isFirstTimeOpened);
    return (valueBool);
  }

  @override
  Widget build(BuildContext context)
  {

    fetchData().then((value)
    {
      setState(() {
        boolVal = value;
      });
    });

    if(boolVal)
    {
      return const DiscScreen();
    }
    else
    {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 160.0,
                width: 240.0,
                margin: const EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/homeLogo.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: FloatingActionButton(
                          heroTag: null,
                          child: const Text("Program\n A",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          onPressed: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FirstProgram()),
                            );
                          }
                        ), 
                      ),

                      Container(
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                        child: Text(aDescription,
                            style: const TextStyle(fontSize: 13),
                            textAlign: TextAlign.center
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: FloatingActionButton(
                          heroTag: null,
                          child: const Text("Program\n B",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          onPressed: () 
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SecondProgram()),
                            );
                          }
                        )
                      ),


                      Container(
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Text(bDescription,
                            style: const TextStyle(fontSize: 13),
                            textAlign: TextAlign.center
                        ),
                      )

                    ],
                  )
                ],
              ),


            ]
          )
        ),
      );
    }
  }
}



//Disclaimer1 screen
class DiscScreen extends StatefulWidget 
{
  const DiscScreen({Key? key}) : super(key: key);

  @override
  State<DiscScreen> createState() => _DisclaimerScreen();
}

class _DisclaimerScreen extends State<DiscScreen> 
{

  String verNum = "ver. 1.0.6";

  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.fromLTRB(30, 35, 30, 10),
                  child: const Text("STOP",
                    style: TextStyle( color: Colors.red, fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: const Text("Do not begin or continue your dry-fire training/practice until you have completed the following steps and CONFIRMING THAT YOUR FIREARM IS UNLOADED AND THERE IS NO LIVE AMMO IN YOUR TRAINING AREA!",
                    style: TextStyle( color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                ),
                
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                          child: const Text("1.",
                            textAlign: TextAlign.start)
                        ),

                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 30, 0),
                            child: 
                              Text("Unload your firearm by removing the magazine and all/any other ammunition from the firearm.",
                              textAlign: TextAlign.start),
                          )
                        ),
                      ],
                    ),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Text("2.",
                            textAlign: TextAlign.start)
                        ),

                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 30, 0),
                            child: 
                              Text("Check and confirm that the chamber of your firearm is empty.",
                              textAlign: TextAlign.start),
                          )
                        ),
                      ],
                    ),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Text("3.",
                            textAlign: TextAlign.start)
                        ),

                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 30, 0),
                            child: 
                              Text("Remove all live ammunition from the practice area and place it in a secure location where you cannot accidentally or unintentionally load your firearm during your dry fire practice and training.",
                              textAlign: TextAlign.start),
                          )
                        ),
                      ],
                    ),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Text("4.",
                            textAlign: TextAlign.start)
                        ),

                        const Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 30, 0),
                            child: 
                              Text("Remove all other firearms from your practice area and place them in a secure location where you will not be able to accidentally begin using a loaded firearm.",
                              textAlign: TextAlign.start),
                          )
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 90,
                          margin: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                          child: FloatingActionButton(
                            heroTag: null,
                            child: const Text("Continue",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            onPressed: ()
                            {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const DiscScreenConfirm()),
                              );
                            }
                          ), 
                        ),
                      ]
                    )

                  ]
                ),
              ]
            ), 

            const Spacer(flex: 1),

            Align(
              alignment: FractionalOffset.bottomRight,
              child: 
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                  child:
                    Text(verNum),
                )
            )
          ]
        )
      ),
    );
  }
}


//Disclaimer2 screen
class DiscScreenConfirm extends StatefulWidget 
{
  const DiscScreenConfirm({Key? key}) : super(key: key);

  @override
  State<DiscScreenConfirm> createState() => _DiscScreenConfirmState();
}

class _DiscScreenConfirmState extends State<DiscScreenConfirm> 
{

  String verNum = "ver. 1.0.6";

  @override
  void initState() 
  {
    super.initState();
  }

  Future<void> saveData() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFrstOpened', false);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.fromLTRB(45, 35, 45, 10),
              child: const Text("By continuing to use the Command Target Shot Timer App you agree and confirm that you:",
                style: TextStyle( fontStyle: FontStyle.italic),
                textAlign: TextAlign.start)
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                  child: const Text("-",
                    textAlign: TextAlign.start)
                ),

                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 50, 0),
                    child: 
                      Text("Have completed the above steps;",
                      textAlign: TextAlign.start),
                  )
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                  child: const Text("-",
                    textAlign: TextAlign.start)
                ),

                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 50, 0),
                    child: 
                      Text("Will conduct your dry-fire training in a safe and responsible manner;",
                      textAlign: TextAlign.start),
                  )
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                  child: const Text("-",
                    textAlign: TextAlign.start)
                ),

                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 50, 0),
                    child: 
                      Text("Will NOT point your firearm at any person during your dry-fire practice/training; and,",
                      textAlign: TextAlign.start),
                  )
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                  child: const Text("-",
                    textAlign: TextAlign.start)
                ),

                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 50, 0),
                    child: 
                      Text("Will not hold Practical Defense Training, Atriarch Training Systems, or any of associates of such, liable for any accidents or injuries that result while using the Command Target Shot Timer App.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                  )
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 90,
                  margin: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                  child: FloatingActionButton(
                    heroTag: null,
                    child: const Text("Continue",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    onPressed: ()
                    {
                      saveData();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
                      );
                    }
                  ), 
                ),
              ]
            ),
            
            const Spacer(flex: 1),

            Align(
              alignment: FractionalOffset.bottomRight,
              child: 
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                  child:
                    Text(verNum),
                )
            )
          ],
        ),
      ),
    );
  }
}








//First Program
class FirstProgram extends StatefulWidget 
{
  const FirstProgram({Key? key}) : super(key: key);

  @override
  State<FirstProgram> createState() => _FirstProgramState();
}

class _FirstProgramState extends State<FirstProgram> 
{
  List<bool> isSelected = [true, false];

  late List<String> pickedSounds;
  late List<String> pickedSoundsBackup;
  List<String> sounds = ['Blue.mp3', 'Eight.mp3', 'Five.mp3', 'Four.mp3', 'Green.mp3', 'Nine.mp3','One.mp3', 
  'Purple.mp3', 'Red.mp3', 'Seven.mp3', 'Six.mp3','Three.mp3', 'Two.mp3', 'Yellow.mp3', 'Circle.mp3', 'Square.mp3', 'Triangle.mp3'];

  String buttonTitle = "Start";
  bool redB = false;
  bool yellowB = false;
  bool blueB = false;
  bool greenB = false;
  bool purpleB = false;
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;
  bool seven = false;
  bool eight = false;
  bool nine = false;
  bool circle = false;
  bool square = false;
  bool triangle = false;

  var partTimeController = TextEditingController(text: '0');

  bool isSelected5sec = true;
  bool isSeleected10Sec = false;
  bool isInitializedSound = false;
  bool isFirstRun = true;
  var random = Random();
  int min = 0;
  int max = 0;
  int secondsDelay = 0;
  int randomCommandIndex = 0;
  int totalAllowableTimeInt = 0;
  int numOfCommandsToUseInSet = 1;
  int minNumOfCommands = 1;
  int maxNumOfCommands = 1;
  String totalAllowTime = "Total Allowable Time";
  double totalAllowableTimeD = 0;



  double delayTimeMinF = 0;
  double delayTimeMaxF = 0.5;
  double parTimeF = 0.0;
  double splitTime = 0.0;
  int numOfRoundsF = 0;

  String numOfRounds = '0';
  
  String imageLoc = 'assets/icon.png';

  AudioPlayer _audioPlayer = AudioPlayer();
  late OverlayEntry _overlayEntry;

  @override
  void initState() 
  {
    AudioPlayer.clearAssetCache();
    pickedSounds = [];
    pickedSoundsBackup = [];

    fetchData();
    
    _overlayEntry = _createOverlayEntry();


    super.initState();
  }


  Future<void> saveData() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('parTime', parTimeF);
    await prefs.setDouble('splitTime', splitTime);
    await prefs.setDouble('delayMin', delayTimeMinF);
    await prefs.setDouble('delayMax', delayTimeMaxF);
    await prefs.setInt('numOfCMin', minNumOfCommands);
    await prefs.setInt('numOfCMax', maxNumOfCommands);
    await prefs.setInt('numRounds', numOfRoundsF);
    await prefs.setBool('rTime5sec', isSelected5sec);
    await prefs.setBool('rTime10sec', isSeleected10Sec);

    await prefs.setBool('red-A', redB);
    await prefs.setBool('yellow-A', yellowB);
    await prefs.setBool('blue-A', blueB);
    await prefs.setBool('green-A', greenB);
    await prefs.setBool('purple-A', purpleB);
    await prefs.setBool('one-A', one);
    await prefs.setBool('two-A', two);
    await prefs.setBool('three-A', three);
    await prefs.setBool('four-A', four);
    await prefs.setBool('five-A', five);
    await prefs.setBool('six-A', six);
    await prefs.setBool('seven-A', seven);
    await prefs.setBool('eight-A', eight);
    await prefs.setBool('nine-A', nine);
    await prefs.setBool('circle-A', circle);
    await prefs.setBool('square-A', square);
    await prefs.setBool('triangle-A', triangle);
  }

  Future<void> fetchData() async
  {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      parTimeF = prefs.getDouble('parTime') ?? 0.0;
      partTimeController.text = parTimeF.toString();
      splitTime = prefs.getDouble('splitTime') ?? 0.0;
      delayTimeMinF = prefs.getDouble('delayMin') ?? 0.0;
      delayTimeMaxF = prefs.getDouble('delayMax') ?? 0.5;
      minNumOfCommands = prefs.getInt('numOfCMin') ?? 1;
      maxNumOfCommands = prefs.getInt('numOfCMax') ?? 1;
      numOfRoundsF = prefs.getInt('numRounds') ?? 0;
      numOfRounds = numOfRoundsF.toString();
      isSelected5sec = prefs.getBool('rTime5sec') ?? true;
      isSeleected10Sec = prefs.getBool('rTime10sec') ?? false;
      isSelected[0] = isSelected5sec;
      isSelected[1] = isSeleected10Sec;

      redB = prefs.getBool('red-A') ?? false;
      yellowB = prefs.getBool('yellow-A') ?? false;
      blueB = prefs.getBool('blue-A') ?? false;
      greenB = prefs.getBool('green-A') ?? false;
      purpleB = prefs.getBool('purple-A') ?? false;
      one = prefs.getBool('one-A') ?? false;
      two = prefs.getBool('two-A') ?? false;
      three = prefs.getBool('three-A') ?? false;
      four = prefs.getBool('four-A') ?? false;
      five = prefs.getBool('five-A') ?? false;
      six = prefs.getBool('six-A') ?? false;
      seven = prefs.getBool('seven-A') ?? false;
      eight = prefs.getBool('eight-A') ?? false;
      nine = prefs.getBool('nine-A') ?? false;
      circle = prefs.getBool('circle-A') ?? false;
      square = prefs.getBool('square-A') ?? false;
      triangle = prefs.getBool('triangle-A') ?? false;
    });
  }

  Future<void> removeData() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('parTime', 0);
    await prefs.setDouble('splitTime', 0.0);
    await prefs.setDouble('delayMin', 0);
    await prefs.setDouble('delayMax', 0.5);
    await prefs.setInt('numOfCMin', 1);
    await prefs.setInt('numOfCMax', 1);
    await prefs.setInt('numRounds', 0);
    await prefs.setBool('rTime5sec', true);
    await prefs.setBool('rTime10sec', false);

    await prefs.setBool('red-A', false);
    await prefs.setBool('yellow-A', false);
    await prefs.setBool('blue-A', false);
    await prefs.setBool('green-A', false);
    await prefs.setBool('purple-A', false);
    await prefs.setBool('one-A', false);
    await prefs.setBool('two-A', false);
    await prefs.setBool('three-A', false);
    await prefs.setBool('four-A', false);
    await prefs.setBool('five-A', false);
    await prefs.setBool('six-A', false);
    await prefs.setBool('seven-A', false);
    await prefs.setBool('eight-A', false);
    await prefs.setBool('nine-A', false);
    await prefs.setBool('circle-A', false);
    await prefs.setBool('square-A', false);
    await prefs.setBool('triangle-A', false);

    fetchData();
  }


  Future<void> changeImage(String chosenSoundStr) async
  {
    if(chosenSoundStr == 'Blue.mp3')
    {
      imageLoc = 'assets/visuals/blue.jpg';
    }
    else if(chosenSoundStr == 'Eight.mp3')
    {
      imageLoc = 'assets/visuals/eight.jpg';
    }
    else if(chosenSoundStr == 'Five.mp3')
    {
      imageLoc = 'assets/visuals/five.jpg';
    }
    else if(chosenSoundStr == 'Four.mp3')
    {
      imageLoc = 'assets/visuals/four.jpg';
    }
    else if(chosenSoundStr == 'Green.mp3')
    {
      imageLoc = 'assets/visuals/green.jpg';
    }
    else if(chosenSoundStr == 'Nine.mp3')
    {
      imageLoc = 'assets/visuals/nine.jpg';
    }
    else if(chosenSoundStr == 'One.mp3')
    {
      imageLoc = 'assets/visuals/one.jpg';
    }
    else if(chosenSoundStr == 'Purple.mp3')
    {
      imageLoc = 'assets/visuals/purple.jpg';
    }
    else if(chosenSoundStr == 'Red.mp3')
    {
      imageLoc = 'assets/visuals/red.jpg';
    }
    else if(chosenSoundStr == 'Seven.mp3')
    {
      imageLoc = 'assets/visuals/seven.jpg';
    }
    else if(chosenSoundStr == 'Six.mp3')
    {
      imageLoc = 'assets/visuals/six.jpg';
    }
    else if(chosenSoundStr == 'Three.mp3')
    {
      imageLoc = 'assets/visuals/three.jpg';
    }
    else if(chosenSoundStr == 'Two.mp3')
    {
      imageLoc = 'assets/visuals/two.jpg';
    }
    else if(chosenSoundStr == 'Yellow.mp3')
    {
      imageLoc = 'assets/visuals/yellow.jpg';
    }
    else if(chosenSoundStr == 'Circle.mp3')
    {
      imageLoc = 'assets/visuals/circle.png';
    }
    else if(chosenSoundStr == 'Square.mp3')
    {
      imageLoc = 'assets/visuals/square.jpg';
    }
    else if(chosenSoundStr == 'Triangle.mp3')
    {
      imageLoc = 'assets/visuals/triangle.png';
    }
  }


  void start() 
  {
    totalAllowableTimeInt = calculateAT();
    numOfCommandsToUseInSet = randomNumOfCommands();

    initialiseSoundList();

    setState(() 
    { 
      totalAllowTime = "Total Allowable Time : " + totalAllowableTimeD.toStringAsFixed(2);

      if(buttonTitle == "Start")
      {
        _audioPlayer = AudioPlayer();
        buttonTitle = "Stop";
        startLogic();
      }
      else
      {
        buttonTitle = "Start";
        pickedSounds.clear();
        pickedSoundsBackup.clear();
        _audioPlayer.dispose();
      }
    });
  }

  void initialiseSoundList()
  {
    if(redB)
    {
      pickedSounds.add(sounds[8]);
    }
    if(yellowB)
    {
      pickedSounds.add(sounds[13]);
    }
    if(blueB)
    {
      pickedSounds.add(sounds[0]);
    }
    if(greenB)
    {
      pickedSounds.add(sounds[4]);
    }
    if(purpleB)
    {
      pickedSounds.add(sounds[7]);
    }
    if(one)
    {
      pickedSounds.add(sounds[6]);
    }
    if(two)
    {
      pickedSounds.add(sounds[12]);
    }
    if(three)
    {
      pickedSounds.add(sounds[11]);
    }
    if(four)
    {
      pickedSounds.add(sounds[3]);
    }
    if(five)
    {
      pickedSounds.add(sounds[2]);
    }
    if(six)
    {
      pickedSounds.add(sounds[10]);
    }
    if(seven)
    {
      pickedSounds.add(sounds[9]);
    }
    if(eight)
    {
      pickedSounds.add(sounds[1]);
    }
    if(nine)
    {
      pickedSounds.add(sounds[5]);
    }
    if(circle)
    {
      pickedSounds.add(sounds[14]);
    }
    if(square)
    {
      pickedSounds.add(sounds[15]);
    }
    if(triangle)
    {
      pickedSounds.add(sounds[16]);
    }

    pickedSoundsBackup = List.from(pickedSounds);
  }


  int randomNumOfCommands()
  {
    return minNumOfCommands + random.nextInt((maxNumOfCommands + 1) - minNumOfCommands);
  }

  void startLogic()
  {
    delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(1));
    delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(1));

    min = int.parse(delayTimeMinF.toString().replaceAll(".", "") + "00");
    max = int.parse(delayTimeMaxF.toString().replaceAll(".", "") + "00");

    
    delayTime(min, max);
  }


  void delayTime(int minT, int maxT)
  {
    if(pickedSounds.isEmpty)
    {
      pickedSounds = List.from(pickedSoundsBackup);
    }

    if(pickedSounds.length == 1)
    {
      randomCommandIndex = 0;
    }
    else
    {
      randomCommandIndex = random.nextInt((pickedSounds.length-1));
    }
    _audioPlayer.setAsset('assets/audio/'+ pickedSounds[randomCommandIndex]);
    changeImage(pickedSounds[randomCommandIndex]);
    secondsDelay = minT + random.nextInt(maxT - minT);

    Future.delayed(Duration(milliseconds: secondsDelay), () 
    {
      playSound();
    });
  }

  
  void playSound() 
  {
    Overlay.of(context)?.insert(_overlayEntry);
    _audioPlayer.play();
    numOfCommandsToUseInSet--;
    delay1();
  }

  void delay1()
  {
    Future.delayed(Duration(milliseconds: totalAllowableTimeInt), () 
    {
      pickedSounds.remove(pickedSounds[randomCommandIndex]);
      _audioPlayer.dispose();
      _audioPlayer = AudioPlayer();
      _audioPlayer.setAsset('assets/audio/Beep.mp3');
      _overlayEntry.remove();
      playBuzzer();
    });
  }

  void playBuzzer()
  {
    _audioPlayer.play();

    _audioPlayer.playerStateStream.listen((state) 
    {
      if (state.processingState == ProcessingState.completed) 
      {
        _audioPlayer.dispose();
        _audioPlayer = AudioPlayer();


        if(numOfCommandsToUseInSet != 0)
        {
          if(pickedSounds.isEmpty)
          {
            pickedSounds = List.from(pickedSoundsBackup);
          }

          if(pickedSounds.length == 1)
          {
            randomCommandIndex = 0;
          }
          else
          {
            randomCommandIndex = random.nextInt((pickedSounds.length-1));
          }
          _audioPlayer.setAsset('assets/audio/'+ pickedSounds[randomCommandIndex]);
          changeImage(pickedSounds[randomCommandIndex]);
          playSound();
        }
        else
        {
          numOfCommandsToUseInSet = randomNumOfCommands();
          _audioPlayer.setAsset('assets/audio/Reholster.mp3');
          delay2();
        }
        
      }
    });
  } 

  void delay2()
  {
    Future.delayed(const Duration(seconds: 1), () 
    {
      playReholster();
    });
  }

  void playReholster() 
  {
    _audioPlayer.play();

    _audioPlayer.playerStateStream.listen((state) 
    {
      if (state.processingState == ProcessingState.completed) 
      {
        _audioPlayer.dispose();
        _audioPlayer = AudioPlayer();
        if(isSelected5sec)
        {
          _audioPlayer.setAsset('assets/audio/FiveSec.mp3');
        }
        else
        {
          _audioPlayer.setAsset('assets/audio/TenSec.mp3');
        }
        playTenCountdown();
      }
    });
  }

  void playTenCountdown() 
  {
    _audioPlayer.play();

    _audioPlayer.playerStateStream.listen((state) 
    {
      if (state.processingState == ProcessingState.completed) 
      {
        _audioPlayer.dispose();
        _audioPlayer = AudioPlayer();
        delayTime(min, max);
      }
    });
  }


  int calculateAT()
  {
    totalAllowableTimeD = ((numOfRoundsF.toDouble() - 1.0) * splitTime) + double.parse(partTimeController.text);

    return int.parse(totalAllowableTimeD.toStringAsFixed(2).replaceAll(".", "") + "0");
  }


  @override
  void dispose() {
    //_audioPlayer.dispose();
    _overlayEntry.remove();
    super.dispose();
  }




  Widget _incrementButton() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        splitTime += 0.05;
        setState(() {
          splitTime = double.parse((splitTime).toStringAsFixed(2));
        });
      },
    );
  }


  Widget _decrementButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(splitTime > 0)
          {
            splitTime -= 0.05;
            splitTime = double.parse((splitTime).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }





  Widget _incrementButtonParTime() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        parTimeF = double.parse(partTimeController.text);
        parTimeF += 0.05;
        parTimeF = double.parse((parTimeF).toStringAsFixed(2));
        setState(() {
          partTimeController.text = parTimeF.toString();
        });
      },
    );
  }


  Widget _decrementButtonParTime() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        parTimeF = double.parse(partTimeController.text);
        if(parTimeF > 0)
        {
          parTimeF -= 0.05;
          parTimeF = double.parse((parTimeF).toStringAsFixed(2));
        }
        setState(() {
          partTimeController.text = parTimeF.toString();
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }




  Widget _incrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMinF += 0.25;
        if((delayTimeMinF + 0.5) > delayTimeMaxF)
        {
          delayTimeMaxF = delayTimeMinF + 0.5;
        }
        setState(() {
          delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
          delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
        });
      },
    );
  }

  Widget _decrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(delayTimeMinF > 0)
          {
            delayTimeMinF -= 0.25;
            delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  Widget _incrementButtonDelayMax() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMaxF += 0.25;
        setState(() {
          delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
        });
      },
    );
  }

  Widget _decrementButtonDelayMax() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if((delayTimeMaxF - 0.25) >= (delayTimeMinF + 0.5))
          {
            delayTimeMaxF -= 0.25;
            delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }




  Widget _incrementButtonNumRounds() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if(numOfRoundsF < 4)
          {
            numOfRoundsF += 1;
            numOfRounds = numOfRoundsF.toString();
          }
        });
      },
    );
  }


  Widget _decrementButtonNumRounds() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(numOfRoundsF > 1)
          {
            numOfRoundsF -= 1;
            numOfRounds = numOfRoundsF.toString();
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  Widget _incrementButtonNumCommandsMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if(minNumOfCommands < maxNumOfCommands)
          {
            minNumOfCommands += 1;
          }
        });
      },
    );
  }

  Widget _decrementButtonNumCommandsMin() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(minNumOfCommands > 1)
          {
            minNumOfCommands -= 1;
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  Widget _incrementButtonNumCommandsMax() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          maxNumOfCommands += 1;
        });
      },
    );
  }

  Widget _decrementButtonNumCommandsMax() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(maxNumOfCommands > minNumOfCommands)
          {
            maxNumOfCommands -= 1;
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }



  OverlayEntry _createOverlayEntry() {

    return OverlayEntry(
      builder: (context) => Positioned.fill(
        //bottom: MediaQuery.of(context).size.height/2,
        //start: (MediaQuery.of(context).size.width/2) - 10,
        left: 5,
        top: 5,
        bottom: 5,
        right: 5,
        child: Image.asset(imageLoc),
      )
    );
  }



  @override
  Widget build(BuildContext context) 
  {
    Wakelock.enable();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: FloatingActionButton(
                        heroTag: null,
                        child: const Text("Back",
                          style: TextStyle(fontSize: 15),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        onPressed: ()
                        {
                          saveData();
                          _audioPlayer.dispose();
                          Navigator.pop(context);
                        }
                      ), 
                    ),
                  ]
                )
              ),

              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6.0)
                ),
                child: Text(totalAllowTime, 
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      width: 120,
                      child: FloatingActionButton(
                        heroTag: null,
                        child: const Text("Reset Input Data",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        backgroundColor: Colors.blue,
                        onPressed: ()
                        {
                          removeData();
                        }
                      ), 
                    ),
                  ]
                )
              ),

              


              Container(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Row(      
                              children: <Widget>[

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Par Time:"),
                                    
                                    Container(
                                      alignment: Alignment.center,
                                      height: 43.0,
                                      width: 55.0,
                                      margin: const EdgeInsets.fromLTRB(14, 5, 15, 0),
                                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child:TextField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical: TextAlignVertical.center,
                                        controller: partTimeController,
                                        style: const TextStyle(fontSize: 18.0),
                                      )
                                    ),
                                  ],
                                ),

                                Column(
                                  children: <Widget> [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      margin: const EdgeInsets.only(bottom: 2.0),
                                      child: _incrementButtonParTime(),
                                    ),

                                    Container(
                                      height: 35,
                                      width: 35,
                                      margin: const EdgeInsets.only(top: 2.0),
                                      child: _decrementButtonParTime(),
                                    ),
                                  ]
                                ),
                              
                              ],
                            ),
                          
                    ),

                    

                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                      child: Row(                           
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Split Time:"),

                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                    padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$splitTime',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),
                              
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButton(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButton(),
                                  ),
                                ]
                              ),
                            ],
                          ),
                    ),
                  
                  ],
                ),
              ),


              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 74),
                      child: const Text("Delay Time:"),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child:const Text(" (Min)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$delayTimeMinF',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),




                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonDelayMin(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonDelayMin(),
                                  ),
                                ]
                              ),



                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(23, 0, 5, 0),
                                    child:const Text(" (Max)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$delayTimeMaxF',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),

                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonDelayMax(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonDelayMax(),
                                  ),
                                ]
                              ),


                        ],
                      ),
                    ),


                  ]
                ),
              ),



              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 38),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Text("Number of Commands"),
                          Text("(Per Set)"),
                        ],
                      )
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child:const Text(" (Min)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$minNumOfCommands',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),




                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonNumCommandsMin(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonNumCommandsMin(),
                                  ),
                                ]
                              ),



                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(23, 0, 5, 0),
                                    child:const Text(" (Max)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$maxNumOfCommands',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),

                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonNumCommandsMax(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonNumCommandsMax(),
                                  ),
                                ]
                              ),


                        ],
                      ),
                    ),


                  ]
                ),
              ),



              Container(
                padding: const EdgeInsets.fromLTRB(30, 30.0, 40, 0),
                child: Row(
                  children: <Widget>[

                    const Flexible(
                      child: Text("Number of Rounds:"),
                    ),
                    

                    Container(
                      width: 55.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:Text(
                        numOfRounds,
                        style: const TextStyle(fontSize: 18.0),
                      )
                    ),

                    Column(
                      children: <Widget> [
                        Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.only(bottom: 2.0),
                          child: _incrementButtonNumRounds(),
                        ),

                        Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.only(top: 2.0),
                          child: _decrementButtonNumRounds(),
                        ),
                      ]
                    ),

                  ],
                ),
              ),


              Container(
                margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 10),
                child: const Text("Reholster Time:"),
              ),


              Container(
                height: 45.0,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 196, 196, 196),
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                ),
                margin:const EdgeInsets.only(top: 10.0),
                child: ToggleButtons(
                  
                  fillColor: Colors.white,
                  borderWidth: 4,
                  color: Colors.white70,
                  selectedColor: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  children: const <Widget>[

                    Padding(
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:15),
                      child: Text(
                        '5 seconds',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:15),
                      child: Text(
                        '10 seconds',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],

                  onPressed: (int index) {
                    setState(() 
                    {
                      isSelected5sec = false;
                      isSeleected10Sec = false;

                      for (int i = 0; i < isSelected.length; i++) 
                      {
                        isSelected[i] = i == index;
                        if(index == 0)
                        {
                          isSelected5sec = true;
                        }
                        else
                        {
                          isSeleected10Sec = true;
                        }
                      }
                    });
                  },
                      
                  isSelected: isSelected,
                ),
              ),


              Container(
                margin: const EdgeInsets.fromLTRB(0, 35.0, 0, 0),
                child: const Text("Select Command Options:"),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Row(
                          children: [
                            Checkbox(
                              value: redB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  redB = !redB;
                                });
                              },
                            ),
                            const Text("Red")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: yellowB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  yellowB = !yellowB;
                                });
                              },
                            ),
                            const Text("Yellow")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: blueB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  blueB = !blueB;
                                });
                              },
                            ),
                            const Text("Blue")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: greenB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  greenB = !greenB;
                                });
                              },
                            ),
                            const Text("Green")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: purpleB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  purpleB = !purpleB;
                                });
                              },
                            ),
                            const Text("Purple")
                          ],),
                        
                      ]
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: one, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    one = !one;
                                  });
                                },
                              ),
                              const Text("1")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: two, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    two = !two;
                                  });
                                },
                              ),
                              const Text("2")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: three, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    three = !three;
                                  });
                                },
                              ),
                              const Text("3")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: four, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    four = !four;
                                  });
                                },
                              ),
                              const Text("4")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: five, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    five = !five;
                                  });
                                },
                              ),
                              const Text("5")
                            ],)
                        ),
                        
                      ]
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: six, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    six = !six;
                                  });
                                },
                              ),
                              const Text("6")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: seven, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    seven = !seven;
                                  });
                                },
                              ),
                              const Text("7")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: eight, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    eight = !eight;
                                  });
                                },
                              ),
                              const Text("8")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: nine, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    nine = !nine;
                                  });
                                },
                              ),
                              const Text("9")
                            ],)
                        ),

                      ]
                    ),




                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: circle, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    circle = !circle;
                                  });
                                },
                              ),
                              const Text("Circle")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: square, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    square = !square;
                                  });
                                },
                              ),
                              const Text("Square")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: triangle, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    triangle = !triangle;
                                  });
                                },
                              ),
                              const Text("Triangle")
                            ],)
                        ),
                      ]
                    )

                  ]
                ),
              ),
            

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 50),
                child: TextButton(
                  onPressed: (() {
                    if(delayTimeMinF != delayTimeMaxF)
                    {
                      saveData();
                      start();
                    }
                  }),
                  child: Text( buttonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue)
                      )
                    )
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}










//Second Program
class SecondProgram extends StatefulWidget 
{
  const SecondProgram({Key? key}) : super(key: key);

  @override
  State<SecondProgram> createState() => _SecondProgramState();
}

class _SecondProgramState extends State<SecondProgram> 
{
  List<bool> isSelected = [true, false];

  late List<String> pickedSounds;
  late List<String> pickedSoundsBackup;
  List<String> sounds = ['Blue.mp3', 'Eight.mp3', 'Five.mp3', 'Four.mp3', 'Green.mp3', 'Nine.mp3','One.mp3', 
  'Purple.mp3', 'Red.mp3', 'Seven.mp3', 'Six.mp3','Three.mp3', 'Two.mp3', 'Yellow.mp3', 'Circle.mp3', 'Square.mp3', 'Triangle.mp3'];

  String buttonTitle = "GO";
  bool redB = false;
  bool yellowB = false;
  bool blueB = false;
  bool greenB = false;
  bool purpleB = false;
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;
  bool seven = false;
  bool eight = false;
  bool nine = false;
  bool circle = false;
  bool square = false;
  bool triangle = false;

  var partTimeController = TextEditingController(text: '0');

  var random = Random();
  int min = 0;
  int max = 0;
  int secondsDelay = 0;
  int randomCommandIndex = 0;
  int totalAllowableTimeInt = 0;
  int numOfCommandsInSet = 1;
  int numOfCommandsToUseInSet = 1;
  int maxNumOfCommands = 1;
  int minNumOfCommands = 1;
  String totalAllowTime = "Total Allowable Time";
  double totalAllowableTimeD = 0;



  double delayTimeMinF = 0;
  double delayTimeMaxF = 0.05;
  double parTimeF = 0.0;
  double splitTime = 0.0;
  int numOfRoundsF = 0;

  String numOfRounds = '0';

  String imageLoc = 'assets/icon.png';



  //free app
  int minDelay = 4000;
  int maxDelay = 8000;
  double parTime = 1.5;

  AudioPlayer _audioPlayer = AudioPlayer();
  late OverlayEntry _overlayEntry;


  @override
  void initState() 
  {
    AudioPlayer.clearAssetCache();
    pickedSounds = [];
    pickedSoundsBackup = [];

    fetchData();

    _overlayEntry = _createOverlayEntry();
    
    super.initState();
  }


  Future<void> saveData() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('parTimeB', parTimeF);
    await prefs.setDouble('splitTimeB', splitTime);
    await prefs.setDouble('delayMinB', delayTimeMinF);
    await prefs.setDouble('delayMaxB', delayTimeMaxF);
    await prefs.setInt('numOfCMinB', minNumOfCommands);
    await prefs.setInt('numOfCMaxB', maxNumOfCommands);
    await prefs.setInt('numRoundsB', numOfRoundsF);

    await prefs.setBool('red-B', redB);
    await prefs.setBool('yellow-B', yellowB);
    await prefs.setBool('blue-B', blueB);
    await prefs.setBool('green-B', greenB);
    await prefs.setBool('purple-B', purpleB);
    await prefs.setBool('one-B', one);
    await prefs.setBool('two-B', two);
    await prefs.setBool('three-B', three);
    await prefs.setBool('four-B', four);
    await prefs.setBool('five-B', five);
    await prefs.setBool('six-B', six);
    await prefs.setBool('seven-B', seven);
    await prefs.setBool('eight-B', eight);
    await prefs.setBool('nine-B', nine);
    await prefs.setBool('circle-B', circle);
    await prefs.setBool('square-B', square);
    await prefs.setBool('triangle-B', triangle);
  }

  Future<void> fetchData() async
  {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      parTimeF = prefs.getDouble('parTimeB') ?? 0.0;
      partTimeController.text = parTimeF.toString();
      splitTime = prefs.getDouble('splitTimeB') ?? 0.0;
      delayTimeMinF = prefs.getDouble('delayMinB') ?? 0.0;
      delayTimeMaxF = prefs.getDouble('delayMaxB') ?? 0.5;
      minNumOfCommands = prefs.getInt('numOfCMinB') ?? 1;
      maxNumOfCommands = prefs.getInt('numOfCMaxB') ?? 1;
      numOfRoundsF = prefs.getInt('numRoundsB') ?? 0;
      numOfRounds = numOfRoundsF.toString();

      redB = prefs.getBool('red-B') ?? false;
      yellowB = prefs.getBool('yellow-B') ?? false;
      blueB = prefs.getBool('blue-B') ?? false;
      greenB = prefs.getBool('green-B') ?? false;
      purpleB = prefs.getBool('purple-B') ?? false;
      one = prefs.getBool('one-B') ?? false;
      two = prefs.getBool('two-B') ?? false;
      three = prefs.getBool('three-B') ?? false;
      four = prefs.getBool('four-B') ?? false;
      five = prefs.getBool('five-B') ?? false;
      six = prefs.getBool('six-B') ?? false;
      seven = prefs.getBool('seven-B') ?? false;
      eight = prefs.getBool('eight-B') ?? false;
      nine = prefs.getBool('nine-B') ?? false;
      circle = prefs.getBool('circle-B') ?? false;
      square = prefs.getBool('square-B') ?? false;
      triangle = prefs.getBool('triangle-B') ?? false;
    });
  }

  Future<void> removeData() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('parTimeB', 0);
    await prefs.setDouble('splitTimeB', 0.0);
    await prefs.setDouble('delayMinB', 0);
    await prefs.setDouble('delayMaxB', 0.5);
    await prefs.setInt('numOfCMinB', 1);
    await prefs.setInt('numOfCMaxB', 1);
    await prefs.setInt('numRoundsB', 0);

    await prefs.setBool('red-B', false);
    await prefs.setBool('yellow-B', false);
    await prefs.setBool('blue-B', false);
    await prefs.setBool('green-B', false);
    await prefs.setBool('purple-B', false);
    await prefs.setBool('one-B', false);
    await prefs.setBool('two-B', false);
    await prefs.setBool('three-B', false);
    await prefs.setBool('four-B', false);
    await prefs.setBool('five-B', false);
    await prefs.setBool('six-B', false);
    await prefs.setBool('seven-B', false);
    await prefs.setBool('eight-B', false);
    await prefs.setBool('nine-B', false);
    await prefs.setBool('circle-B', false);
    await prefs.setBool('square-B', false);
    await prefs.setBool('triangle-B', false);

    fetchData();
  }


  Future<void> changeImage(String chosenSoundStr) async
  {
    if(chosenSoundStr == 'Blue.mp3')
    {
      imageLoc = 'assets/visuals/blue.jpg';
    }
    else if(chosenSoundStr == 'Eight.mp3')
    {
      imageLoc = 'assets/visuals/eight.jpg';
    }
    else if(chosenSoundStr == 'Five.mp3')
    {
      imageLoc = 'assets/visuals/five.jpg';
    }
    else if(chosenSoundStr == 'Four.mp3')
    {
      imageLoc = 'assets/visuals/four.jpg';
    }
    else if(chosenSoundStr == 'Green.mp3')
    {
      imageLoc = 'assets/visuals/green.jpg';
    }
    else if(chosenSoundStr == 'Nine.mp3')
    {
      imageLoc = 'assets/visuals/nine.jpg';
    }
    else if(chosenSoundStr == 'One.mp3')
    {
      imageLoc = 'assets/visuals/one.jpg';
    }
    else if(chosenSoundStr == 'Purple.mp3')
    {
      imageLoc = 'assets/visuals/purple.jpg';
    }
    else if(chosenSoundStr == 'Red.mp3')
    {
      imageLoc = 'assets/visuals/red.jpg';
    }
    else if(chosenSoundStr == 'Seven.mp3')
    {
      imageLoc = 'assets/visuals/seven.jpg';
    }
    else if(chosenSoundStr == 'Six.mp3')
    {
      imageLoc = 'assets/visuals/six.jpg';
    }
    else if(chosenSoundStr == 'Three.mp3')
    {
      imageLoc = 'assets/visuals/three.jpg';
    }
    else if(chosenSoundStr == 'Two.mp3')
    {
      imageLoc = 'assets/visuals/two.jpg';
    }
    else if(chosenSoundStr == 'Yellow.mp3')
    {
      imageLoc = 'assets/visuals/yellow.jpg';
    }
    else if(chosenSoundStr == 'Circle.mp3')
    {
      imageLoc = 'assets/visuals/circle.png';
    }
    else if(chosenSoundStr == 'Square.mp3')
    {
      imageLoc = 'assets/visuals/square.jpg';
    }
    else if(chosenSoundStr == 'Triangle.mp3')
    {
      imageLoc = 'assets/visuals/triangle.png';
    }
  }


  void start() 
  {
    totalAllowableTimeInt = calculateAT();

    initialiseSoundList();

    setState(() 
    { 
      totalAllowTime = "Total Allowable Time : " + totalAllowableTimeD.toStringAsFixed(2);

      if(buttonTitle == "GO")
      {
        numOfCommandsToUseInSet = randomNumOfCommands();
        _audioPlayer = AudioPlayer();
        buttonTitle = "-";
        startLogic();
      }
      else
      {
        buttonTitle = "GO";
        pickedSounds.clear();
        pickedSoundsBackup.clear();
        _audioPlayer.dispose();
      }
    });
  }

  void initialiseSoundList()
  {
    if(redB)
    {
      pickedSounds.add(sounds[8]);
    }
    if(yellowB)
    {
      pickedSounds.add(sounds[13]);
    }
    if(blueB)
    {
      pickedSounds.add(sounds[0]);
    }
    if(greenB)
    {
      pickedSounds.add(sounds[4]);
    }
    if(purpleB)
    {
      pickedSounds.add(sounds[7]);
    }
    if(one)
    {
      pickedSounds.add(sounds[6]);
    }
    if(two)
    {
      pickedSounds.add(sounds[12]);
    }
    if(three)
    {
      pickedSounds.add(sounds[11]);
    }
    if(four)
    {
      pickedSounds.add(sounds[3]);
    }
    if(five)
    {
      pickedSounds.add(sounds[2]);
    }
    if(six)
    {
      pickedSounds.add(sounds[10]);
    }
    if(seven)
    {
      pickedSounds.add(sounds[9]);
    }
    if(eight)
    {
      pickedSounds.add(sounds[1]);
    }
    if(nine)
    {
      pickedSounds.add(sounds[5]);
    }
    if(circle)
    {
      pickedSounds.add(sounds[14]);
    }
    if(square)
    {
      pickedSounds.add(sounds[15]);
    }
    if(triangle)
    {
      pickedSounds.add(sounds[16]);
    }

    pickedSoundsBackup = List.from(pickedSounds);
  }


  int randomNumOfCommands()
  {
    return minNumOfCommands + random.nextInt((maxNumOfCommands+1)- minNumOfCommands);
  }

  void startLogic()
  {
    delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(1));
    delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(1));

    min = int.parse(delayTimeMinF.toString().replaceAll(".", "") + "00");
    max = int.parse(delayTimeMaxF.toString().replaceAll(".", "") + "00");

    
    delayTime(min, max);
  }


  void delayTime(int minT, int maxT)
  {
    if(pickedSounds.isEmpty)
    {
      pickedSounds = List.from(pickedSoundsBackup);
    }

    if(pickedSounds.length == 1)
    {
      randomCommandIndex = 0;
    }
    else
    {
      randomCommandIndex = random.nextInt((pickedSounds.length-1));
    }
    _audioPlayer.setAsset('assets/audio/'+ pickedSounds[randomCommandIndex]);
    changeImage(pickedSounds[randomCommandIndex]);
    secondsDelay = minT + random.nextInt(maxT - minT);

    Future.delayed(Duration(milliseconds: secondsDelay), () 
    {
      playSound();
    });
  }

  
  void playSound() 
  {
    Overlay.of(context)?.insert(_overlayEntry);
    _audioPlayer.play();
    numOfCommandsToUseInSet--;
    delay1();
  }

  void delay1()
  {
    Future.delayed(Duration(milliseconds: totalAllowableTimeInt), () 
    {
      pickedSounds.remove(pickedSounds[randomCommandIndex]);
      _audioPlayer.dispose();
      _audioPlayer = AudioPlayer();
      _audioPlayer.setAsset('assets/audio/Beep.mp3');
      _overlayEntry.remove();
      playBuzzer();
    });
  }

  void playBuzzer()
  {
    _audioPlayer.play();

    _audioPlayer.playerStateStream.listen((state) 
    {
      if (state.processingState == ProcessingState.completed) 
      {
        _audioPlayer.dispose();

        if(numOfCommandsToUseInSet != 0)
        {
          _audioPlayer = AudioPlayer();

          if(pickedSounds.isEmpty)
          {
            pickedSounds = List.from(pickedSoundsBackup);
          }

          if(pickedSounds.length == 1)
          {
            randomCommandIndex = 0;
          }
          else
          {
            randomCommandIndex = random.nextInt((pickedSounds.length-1));
          }
          _audioPlayer.setAsset('assets/audio/'+ pickedSounds[randomCommandIndex]);
          changeImage(pickedSounds[randomCommandIndex]);
          playSound();

        }
        else
        {
          setState(() 
          {
            buttonTitle = "GO";
          });
          pickedSounds.clear();
          pickedSoundsBackup.clear();
          _audioPlayer.dispose();
        }
      }
    });
  } 


  int calculateAT()
  {
    totalAllowableTimeD = ((numOfRoundsF.toDouble() - 1.0) * splitTime) + double.parse(partTimeController.text);

    return int.parse(totalAllowableTimeD.toStringAsFixed(2).replaceAll(".", "") + "0");
  }


  @override
  void dispose() {
    //_audioPlayer.dispose();
    super.dispose();
  }




  Widget _incrementButton() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        splitTime += 0.05;
        setState(() {
          splitTime = double.parse((splitTime).toStringAsFixed(2));
        });
      },
    );
  }


  Widget _decrementButton() {
    return FloatingActionButton(
        heroTag: null,
        onPressed: () {
          setState(() {
            if(splitTime > 0)
            {
              splitTime -= 0.05;
              splitTime = double.parse((splitTime).toStringAsFixed(2));
            }
          });
        },
        child: const Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white);
  }





  Widget _incrementButtonParTime() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        parTimeF = double.parse(partTimeController.text);
        parTimeF += 0.05;
        parTimeF = double.parse((parTimeF).toStringAsFixed(2));
        setState(() {
          partTimeController.text = parTimeF.toString();
        });
      },
    );
  }


  Widget _decrementButtonParTime() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        parTimeF = double.parse(partTimeController.text);
        if(parTimeF > 0)
        {
          parTimeF -= 0.05;
          parTimeF = double.parse((parTimeF).toStringAsFixed(2));
        }
        setState(() {
          partTimeController.text = parTimeF.toString();
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }




  Widget _incrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMinF += 0.25;
        if((delayTimeMinF + 0.5) > delayTimeMaxF)
        {
          delayTimeMaxF = delayTimeMinF + 0.5;
        }
        setState(() {
          delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
          delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
        });
      },
    );
  }

  Widget _decrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(delayTimeMinF > 0)
          {
            delayTimeMinF -= 0.25;
            delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  Widget _incrementButtonDelayMax() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMaxF += 0.25;
        setState(() {
          delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
        });
      },
    );
  }

  Widget _decrementButtonDelayMax() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if((delayTimeMaxF - 0.25) >= (delayTimeMinF + 0.5))
          {
            delayTimeMaxF -= 0.25;
            delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }




  Widget _incrementButtonNumRounds() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if(numOfRoundsF < 4)
          {
            numOfRoundsF += 1;
            numOfRounds = numOfRoundsF.toString();
          }
        });
      },
    );
  }


  Widget _decrementButtonNumRounds() {
    return FloatingActionButton(
        heroTag: null,
        onPressed: () {
          setState(() {
            if(numOfRoundsF > 1)
            {
              numOfRoundsF -= 1;
              numOfRounds = numOfRoundsF.toString();
            }
          });
        },
        child: const Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white);
  }


    Widget _incrementButtonNumCommandsMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if(minNumOfCommands < maxNumOfCommands)
          {
            minNumOfCommands += 1;
          }
        });
      },
    );
  }

  Widget _decrementButtonNumCommandsMin() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(minNumOfCommands > 1)
          {
            minNumOfCommands -= 1;
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  Widget _incrementButtonNumCommandsMax() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          maxNumOfCommands += 1;
        });
      },
    );
  }
  

  Widget _decrementButtonNumCommandsMax() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        setState(() {
          if(maxNumOfCommands > minNumOfCommands)
          {
            maxNumOfCommands -= 1;
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }



  OverlayEntry _createOverlayEntry() {

    return OverlayEntry(
      builder: (context) => Positioned.fill(
        //bottom: MediaQuery.of(context).size.height/2,
        //start: (MediaQuery.of(context).size.width/2) - 10,
        left: 5,
        top: 5,
        bottom: 5,
        right: 5,
        child: Image.asset(imageLoc),
      )
    );
  }


  @override
  Widget build(BuildContext context) 
  {
    Wakelock.enable();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: FloatingActionButton(
                        heroTag: null,
                        child: const Text("Back",
                          style: TextStyle(fontSize: 15),
                        ),
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        onPressed: ()
                        {
                          saveData();
                          _audioPlayer.dispose();
                          Navigator.pop(context);
                        }
                      ), 
                    ),
                  ]
                )
              ),


              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6.0)
                ),
                child: Text(totalAllowTime, 
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),



              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      width: 120,
                      child: FloatingActionButton(
                        heroTag: null,
                        child: const Text("Reset Input Data",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        backgroundColor: Colors.blue,
                        onPressed: ()
                        {
                          removeData();
                        }
                      ), 
                    ),
                  ]
                )
              ),
              


              Container(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[


                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Row(                           
                            children: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Par Time:"),
                                  
                                  Container(
                                    alignment: Alignment.center,
                                    height: 43.0,
                                    width: 55.0,
                                    margin: const EdgeInsets.fromLTRB(14, 5, 15, 0),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:TextField(
                                      textAlign: TextAlign.center,
                                      textAlignVertical: TextAlignVertical.center,
                                      controller: partTimeController,
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ]
                              ),

                              Column(
                                children: <Widget> [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonParTime(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonParTime(),
                                  ),
                                ]
                              ),
                              
                            ],
                          ),
                    ),

                    

                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                      child: Row(                           
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Column(
                                children: [
                                  const Text("Split Time:"),

                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                    padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$splitTime',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ]
                              ),

                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButton(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButton(),
                                  ),
                                ]
                              ),
                            ],
                          ),
                    ),
                    
                  ],
                ),
              ),


              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 74),
                      child: const Text("Delay Time:"),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[


                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child:const Text(" (Min)",
                                    style: TextStyle(fontSize: 12.0),
                                  )
                                ),

                                Container(
                                  width: 60.0,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child:Text(
                                    '$delayTimeMinF',
                                    style: const TextStyle(fontSize: 18.0),
                                  )
                                ),

                              ],
                            ),



                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonDelayMin(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonDelayMin(),
                                  ),
                                ]
                              ),


                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(24, 0, 5, 0),
                                    child:const Text(" (Max)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$delayTimeMaxF',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),


                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonDelayMax(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonDelayMax(),
                                  ),
                                ]
                              ),
                        ],
                      ),
                    ),

                  ]
                ),
              ),

              



              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 38),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Text("Number of Commands"),
                          Text("(Per Set)"),
                        ],
                      )
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child:const Text(" (Min)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$minNumOfCommands',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),




                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonNumCommandsMin(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonNumCommandsMin(),
                                  ),
                                ]
                              ),



                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(23, 0, 5, 0),
                                    child:const Text(" (Max)",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ),

                                  Container(
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:Text(
                                      '$maxNumOfCommands',
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  ),
                                ],
                              ),

                          
                              Column(
                                children: <Widget> [

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(bottom: 2.0),
                                    child: _incrementButtonNumCommandsMax(),
                                  ),

                                  Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(top: 2.0),
                                    child: _decrementButtonNumCommandsMax(),
                                  ),
                                ]
                              ),


                        ],
                      ),
                    ),


                  ]
                ),
              ),




              Container(
                padding: const EdgeInsets.fromLTRB(30, 30.0, 40, 0),
                child: Row(
                  children: <Widget>[

                    const Flexible(
                      child: Text("Number of Rounds:"),
                    ),
                    

                    Container(
                      width: 55.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:Text(
                        numOfRounds,
                        style: const TextStyle(fontSize: 18.0),
                      )
                    ),

                    Column(
                      children: <Widget> [
                        Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.only(bottom: 2.0),
                          child: _incrementButtonNumRounds(),
                        ),

                        Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.only(top: 2.0),
                          child: _decrementButtonNumRounds(),
                        ),
                      ]
                    ),

                  ],
                ),
              ),



              Container(
                margin: const EdgeInsets.fromLTRB(0, 35.0, 0, 0),
                child: const Text("Select Command Options:"),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Row(
                          children: [
                            Checkbox(
                              value: redB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  redB = !redB;
                                });
                              },
                            ),
                            const Text("Red")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: yellowB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  yellowB = !yellowB;
                                });
                              },
                            ),
                            const Text("Yellow")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: blueB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  blueB = !blueB;
                                });
                              },
                            ),
                            const Text("Blue")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: greenB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  greenB = !greenB;
                                });
                              },
                            ),
                            const Text("Green")
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: purpleB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  purpleB = !purpleB;
                                });
                              },
                            ),
                            const Text("Purple")
                          ],),
                        
                      ]
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: one, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    one = !one;
                                  });
                                },
                              ),
                              const Text("1")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: two, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    two = !two;
                                  });
                                },
                              ),
                              const Text("2")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: three, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    three = !three;
                                  });
                                },
                              ),
                              const Text("3")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: four, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    four = !four;
                                  });
                                },
                              ),
                              const Text("4")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: five, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    five = !five;
                                  });
                                },
                              ),
                              const Text("5")
                            ],)
                        ),
                        
                      ]
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: six, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    six = !six;
                                  });
                                },
                              ),
                              const Text("6")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: seven, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    seven = !seven;
                                  });
                                },
                              ),
                              const Text("7")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: eight, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    eight = !eight;
                                  });
                                },
                              ),
                              const Text("8")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: nine, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    nine = !nine;
                                  });
                                },
                              ),
                              const Text("9")
                            ],)
                        ),

                      ]
                    ),




                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: circle, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    circle = !circle;
                                  });
                                },
                              ),
                              const Text("Circle")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: square, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    square = !square;
                                  });
                                },
                              ),
                              const Text("Square")
                            ],)
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: triangle, 
                                onChanged: (bool? value) {
                                  setState(() {
                                    triangle = !triangle;
                                  });
                                },
                              ),
                              const Text("Triangle")
                            ],)
                        ),
                      ]
                    )

                  ]
                ),
              ),
            

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 50),
                child: TextButton(
                  onPressed: (() {
                    if(delayTimeMinF != delayTimeMaxF)
                    {
                      saveData();
                      start();
                    }
                  }),
                  child: Text( buttonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue)
                      )
                    )
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}




