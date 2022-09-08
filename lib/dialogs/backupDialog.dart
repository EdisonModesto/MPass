import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/providers/allPassProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class backupDialog extends StatefulWidget {
  const backupDialog({Key? key}) : super(key: key);

  @override
  State<backupDialog> createState() => _backupDialogState();
}

class _backupDialogState extends State<backupDialog> {

  late File jsonFile;
  late Directory dir;
  String fileName = "BACKUP.json";
  bool fileExists = false;
  List<dynamic> backupAccount = [];
  int _length = 0;
  //late Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();


    getExternalStorageDirectory().then((value) => {
      dir = value!,
      print(dir),
      jsonFile = File(dir.path + "/" + fileName),
      fileExists = jsonFile.existsSync(),
      if (fileExists) setState((){
        backupAccount.clear();
        backupAccount.addAll(jsonDecode(jsonFile.readAsLinesSync()[0]));
        _length = backupAccount.length;
      })
      else{
        createFile([], dir, fileName)
        }
    });



  }

  void createFile(List<dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String dateString = date.toString().replaceAll("00:00:00.000", "");
    var passProvider = context.read<allPassProvider>();
    List<dynamic> newEntry = [dateString, passProvider.Title, passProvider.Email, passProvider.Password];
    if(fileExists){
      List<dynamic> content = jsonDecode(jsonFile.readAsStringSync());
      print("File exists");
    //  List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      content.add(newEntry);
      jsonFile.writeAsStringSync(json.encode(content));
    } else{
      List<dynamic> content = jsonDecode(jsonFile.readAsStringSync());
      print("File does not exist!");
      content.add(newEntry);
      createFile(content, dir, fileName);
    }

    setState((){
      backupAccount.clear();
      backupAccount.addAll( jsonDecode(jsonFile.readAsLinesSync()[0]));
      _length = backupAccount.length;
    });
    print(jsonDecode(jsonFile.readAsLinesSync()[0]));

    /*
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);*/
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 450,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.all(25),

          child: Column(
            children:  [
              const Text(
                  "Backup & Restore",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: _length,
                    itemBuilder: (context, index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(backupAccount[index][0].toString()),
                        IconButton(
                            onPressed: (){
                              //backupAccount.clear();
                              //backupAccount.addAll( jsonDecode(jsonFile.readAsLinesSync()[0]));
                              print(backupAccount[index][1].toString());
                              showDialog(context: context, builder: (BuildContext context){
                                return Center(
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      padding: const EdgeInsets.all(25),
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: 250,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: const AutoSizeText(
                                              "Restore",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent,
                                                fontSize: 18
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const AutoSizeText(
                                              "Are you sure you want to restore this backup? All currently saved passwords will be replaced once restored.",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          AutoSizeText(
                                            "Backup Date: ${backupAccount[index][0].toString()}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Close", style: TextStyle(color: Colors.grey))),
                                              TextButton(onPressed: (){
                                                Navigator.pop(context);
                                                context.read<allPassProvider>().restore(backupAccount[index][1], backupAccount[index][2], backupAccount[index][3]);
                                                Fluttertoast.showToast(msg: "Backup has been restored");
                                                }, child: const Text("Restore", style: TextStyle(color: Colors.redAccent),))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.restore,
                              color: Colors.redAccent,
                            )
                        )
                      ],
                    );
                    }
                ),
              ),

              ElevatedButton(
                onPressed: (){
                  writeToFile("hello", "1");
                },
                child: const Text("Create new Backup"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
