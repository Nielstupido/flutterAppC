import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  List<String> sounds = ['Circle.mp3', 'Square.mp3', 'Triangle.mp3'];

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

  double partTimeController = 1.5;

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
  int numOfCommandsInSet = 1;
  int numOfCommandsInSetBackup = 1;
  String totalAllowTime = "Total Allowable Time";
  double totalAllowableTimeD = 0;



  double delayTimeMinF = 0;
  double delayTimeMaxF = 0.05;
  double splitTime = 0.5;
  double numOfRoundsF = 1;

  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() 
  {
    AudioPlayer.clearAssetCache();
    pickedSounds = [];
    pickedSoundsBackup = [];

    setState(() {
      isSelected = [true, false];
    });
    super.initState();
  }


  void start() 
  {
    totalAllowableTimeInt = calculateAT();
    numOfCommandsToUseInSet = numOfCommandsInSet;
    numOfCommandsInSetBackup = numOfCommandsInSet;

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

    secondsDelay = minT + random.nextInt(maxT - minT);

    Future.delayed(Duration(milliseconds: secondsDelay), () 
    {
      playSound();
    });
  }

  
  void playSound() 
  {
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

          playSound();

        }
        else
        {
          numOfCommandsToUseInSet = numOfCommandsInSetBackup;
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
    totalAllowableTimeD = ((numOfRoundsF - 1.0) * splitTime) + partTimeController;

    return int.parse(totalAllowableTimeD.toStringAsFixed(2).replaceAll(".", "") + "0");
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  Widget _incrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMinF += 0.25;
        setState(() {
          delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
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
          if(delayTimeMaxF > 0.05)
          {
            delayTimeMaxF -= 0.25;
            delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
          }
        });
      },
      child: const Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white);
  }


  @override
  Widget build(BuildContext context) 
  {
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
                        shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        onPressed: ()
                        {
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
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    const Flexible(
                      child: Text("Par Time:"),
                    ),

                    Row(                           
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: 43.0,
                            width: 55.0,
                            margin: const EdgeInsets.fromLTRB(5, 0, 25, 0),
                            decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: const Text("1.5", 
                              style: TextStyle(fontSize: 18.0),
                            )
                          ),                      
                        ],
                      ),



                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child:Text("Split Time:"),
                      ),
                    ),
                    

                    Row(                           
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:const Text(
                            "0.5",
                            style: TextStyle(fontSize: 18.0),
                          )
                         ),
                      ],
                    ),



                  ],
                ),
              ),


              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 2, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Delay"),
                          Text("Time:"),
                        ],
                      )
                    ),

                        Container(
                          width: 60.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:Text(
                            '$delayTimeMinF',
                            style: const TextStyle(fontSize: 18.0),
                          )
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child:const Text(" (Min)",
                            style: TextStyle(fontSize: 12.0),
                          )
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


                        Container(
                          width: 60.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:Text(
                            '$delayTimeMaxF',
                            style: const TextStyle(fontSize: 18.0),
                          )
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child:const Text(" (Max)",
                            style: TextStyle(fontSize: 12.0),
                          )
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



              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 40, 0),
                child: Row(
                  children: <Widget>[

                    const Flexible(
                      child: Text("Number of Commands(Per Set):"),
                    ),
                    

                    Container(
                      width: 55.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ),
                  ],
                ),
              ),




              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 40, 0),
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
                      child:const Text(
                        "1",
                        style: TextStyle(fontSize: 18.0),
                      )
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
                                  redB = redB;
                                });
                              },
                            ),
                            const Text("Red",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: yellowB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  yellowB = yellowB;
                                });
                              },
                            ),
                            const Text("Yellow",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: blueB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  blueB = blueB;
                                });
                              },
                            ),
                            const Text("Blue",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: greenB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  greenB = greenB;
                                });
                              },
                            ),
                            const Text("Green",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: purpleB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  purpleB = purpleB;
                                });
                              },
                            ),
                            const Text("Purple",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    one = one;
                                  });
                                },
                              ),
                              const Text("1",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    two = two;
                                  });
                                },
                              ),
                              const Text("2",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    three = three;
                                  });
                                },
                              ),
                              const Text("3",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    four = four;
                                  });
                                },
                              ),
                              const Text("4",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    five = five;
                                  });
                                },
                              ),
                              const Text("5",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    six = six;
                                  });
                                },
                              ),
                              const Text("6",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    seven = seven;
                                  });
                                },
                              ),
                              const Text("7",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    eight = eight;
                                  });
                                },
                              ),
                              const Text("8",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    nine = nine;
                                  });
                                },
                              ),
                              const Text("9",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
  List<String> sounds = ['Circle.mp3', 'Square.mp3', 'Triangle.mp3'];

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

  double partTimeController = 1.5;

  var random = Random();
  int min = 0;
  int max = 0;
  int secondsDelay = 0;
  int randomCommandIndex = 0;
  int totalAllowableTimeInt = 0;
  int numOfCommandsInSet = 1;
  int numOfCommandsToUseInSet = 1;
  String totalAllowTime = "Total Allowable Time";
  double totalAllowableTimeD = 0;



  double delayTimeMinF = 0;
  double delayTimeMaxF = 0.05;
  double parTimeF = 0.0;
  double splitTime = 0.5;
  double numOfRoundsF = 1.0;


  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() 
  {
    AudioPlayer.clearAssetCache();
    pickedSounds = [];
    pickedSoundsBackup = [];

    setState(() {
      isSelected = [true, false];
    });
    super.initState();
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
        numOfCommandsToUseInSet = numOfCommandsInSet;
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

    secondsDelay = minT + random.nextInt(maxT - minT);

    Future.delayed(Duration(milliseconds: secondsDelay), () 
    {
      playSound();
    });
  }

  
  void playSound() 
  {
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
    totalAllowableTimeD = ((numOfRoundsF - 1.0) * splitTime) + partTimeController;

    return int.parse(totalAllowableTimeD.toStringAsFixed(2).replaceAll(".", "") + "0");
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  Widget _incrementButtonDelayMin() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        delayTimeMinF += 0.25;
        setState(() {
          delayTimeMinF = double.parse((delayTimeMinF).toStringAsFixed(2));
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
            if(delayTimeMaxF > 0.05)
            {
              delayTimeMaxF -= 0.25;
              delayTimeMaxF = double.parse((delayTimeMaxF).toStringAsFixed(2));
            }
          });
        },
        child: const Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white);
  }


  @override
  Widget build(BuildContext context) 
  {
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
                        shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        onPressed: ()
                        {
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
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    const Flexible(
                      child: Text("Par Time:"),
                    ),

                    Row(                           
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: 43.0,
                            width: 55.0,
                            margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                            decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child:const Text(
                              "1.5",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ),
                        ],
                      ),



                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child:Text("Split Time:"),
                      ),
                    ),
                    

                    Row(                           
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: const Text(
                            "0.5",
                            style: TextStyle(fontSize: 18.0),
                          )
                         ),
                      ],
                    ),



                  ],
                ),
              ),


              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 2, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Delay"),
                          Text("Time:"),
                        ],
                      )
                    ),

                        Container(
                          width: 60.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:Text(
                            '$delayTimeMinF',
                            style: const TextStyle(fontSize: 18.0),
                          )
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child:const Text(" (Min)",
                            style: TextStyle(fontSize: 12.0),
                          )
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


                        Container(
                          width: 60.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:Text(
                            '$delayTimeMaxF',
                            style: const TextStyle(fontSize: 18.0),
                          )
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child:const Text(" (Max)",
                            style: TextStyle(fontSize: 12.0),
                          )
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



              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 40, 0),
                child: Row(
                  children: <Widget>[

                    const Flexible(
                      child: Text("Number of Commands(Per Set):"),
                    ),
                    

                    Container(
                      width: 55.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ),
                  ],
                ),
              ),




              Container(
                padding: const EdgeInsets.fromLTRB(10, 30.0, 40, 0),
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
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 18.0),
                      )
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
                                  redB = redB;
                                });
                              },
                            ),
                            const Text("Red",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: yellowB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  yellowB = yellowB;
                                });
                              },
                            ),
                            const Text("Yellow",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: blueB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  blueB = blueB;
                                });
                              },
                            ),
                            const Text("Blue",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: greenB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  greenB = greenB;
                                });
                              },
                            ),
                            const Text("Green",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
                          ],),

                        Row(
                          children: [
                            Checkbox(
                              value: purpleB, 
                              onChanged: (bool? value) {
                                setState(() {
                                  purpleB = purpleB;
                                });
                              },
                            ),
                            const Text("Purple",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    one = one;
                                  });
                                },
                              ),
                              const Text("1",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    two = two;
                                  });
                                },
                              ),
                              const Text("2",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    three = three;
                                  });
                                },
                              ),
                              const Text("3",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    four = four;
                                  });
                                },
                              ),
                              const Text("4",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    five = five;
                                  });
                                },
                              ),
                              const Text("5",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    six = six;
                                  });
                                },
                              ),
                              const Text("6",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    seven = seven;
                                  });
                                },
                              ),
                              const Text("7",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    eight = eight;
                                  });
                                },
                              ),
                              const Text("8",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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
                                    nine = nine;
                                  });
                                },
                              ),
                              const Text("9",
                              style: TextStyle(
                                color: Colors.red,
                              ),)
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




