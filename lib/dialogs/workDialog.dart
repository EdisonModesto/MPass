import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:provider/provider.dart';

import '../providers/allPassProvider.dart';
import '../providers/colors.dart';

class workDialog extends StatefulWidget {
  const workDialog({Key? key}) : super(key: key);

  @override
  State<workDialog> createState() => _workDialogState();
}

class _workDialogState extends State<workDialog> {

  AppColors colorObject = AppColors();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  "Work Accounts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: context.watch<workProvider>().Title.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.all(0),
                        leading: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Image.asset("assets/images/fbIcon.png"),
                        ),

                        title: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(

                                context.watch<workProvider>().Title[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                              AutoSizeText(context.watch<workProvider>().Email[index],
                                //_Emails![index],
                                style: const TextStyle(
                                    fontSize: 12),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),

                        trailing: IconButton(
                          onPressed: () {
                            context.read<allPassProvider>().delWork(int.parse(context.read<workProvider>().pointer[index]));
                            context.read<workProvider>().deleteAllPass(index);
                            Fluttertoast.showToast(msg: "Account removed from work category!");
                          },
                          icon: Text("-", style: TextStyle(fontWeight: FontWeight.bold),),
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Close", style: TextStyle(color: Colors.grey),)),
                  TextButton(
                      onPressed: (){
                        showDialog(context: context, builder: (BuildContext context) {
                          return Center(
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 350,
                                child: Column(
                                  children: [
                                    const Text("Add to Work Category", style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                          shrinkWrap:  true,
                                          itemCount: context.watch<allPassProvider>().Title.length,
                                          padding: EdgeInsets.only(top: 20, bottom: 20),
                                          itemBuilder: (BuildContext context, int index){
                                            return ListTile(
                                              onTap: () {},
                                              contentPadding: const EdgeInsets.all(0),
                                              leading: Container(
                                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                child: Image.asset("assets/images/fbIcon.png"),
                                              ),

                                              title: Container(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(context.watch<allPassProvider>().Title[index],
                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                    ),
                                                    AutoSizeText(context.watch<allPassProvider>().Email[index],
                                                      //_Emails![index],
                                                      style: const TextStyle(fontSize: 12),
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                              ),

                                              trailing: IconButton(
                                                onPressed: () {
                                                  if(context.read<allPassProvider>().isWork[index] == "0") {
                                                    context.read<workProvider>().addWork(context.read<allPassProvider>().Title[index], context.read<allPassProvider>().Email[index], context.read<allPassProvider>().Password[index], index.toString());
                                                    context.read<allPassProvider>().addWork(index);
                                                    Fluttertoast.showToast(msg: "Account added!");
                                                  }else{
                                                    Fluttertoast.showToast(msg: "Account already on Work!");
                                                    }
                                                  },
                                                icon: Icon(Icons.add),
                                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                              ),
                                            );
                                          }),
                                    ),
                                    ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Done"))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child: Text("Add Account", style: TextStyle(
                      color: colorObject.primary[context.read<colorProvider>().colIndex],
                  ))
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
