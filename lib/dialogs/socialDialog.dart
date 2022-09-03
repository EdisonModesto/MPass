import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpass/categories/social.dart';
import 'package:mpass/colors/AppColors.dart';
import 'package:mpass/passwords.dart';
import 'package:mpass/providers/allPassProvider.dart';
import 'package:mpass/providers/colors.dart';
import 'package:mpass/providers/socialProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class socialDialog extends StatefulWidget {
  const socialDialog({Key? key}) : super(key: key);

  @override
  State<socialDialog> createState() => _socialDialogState();
}

class _socialDialogState extends State<socialDialog> {

  AppColors colorObject = AppColors();

  @override
  void initState() {

    super.initState();
  }

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
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400,
          child: Column(
            children: [
              const Text("Social Accounts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: context.watch<socialProvider>().Title.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
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

                                context.watch<socialProvider>().Title[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                              AutoSizeText(context.watch<socialProvider>().Email[index],
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
                          context.read<allPassProvider>().delSocial(int.parse(context.read<socialProvider>().pointer[index]));
                          context.read<socialProvider>().deleteAllPass(index);
                          Fluttertoast.showToast(msg: "Account removed from social category!");

                        },
                        icon: const Text("-", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                    const Text("Add to Social Category",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                          shrinkWrap:  true,
                                          itemCount: context.watch<allPassProvider>().Title.length,
                                          padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                                              if(context.read<allPassProvider>().isSocial[index] == "0") {
                                                context.read<socialProvider>().addSocial(context.read<allPassProvider>().Title[index], context.read<allPassProvider>().Email[index], context.read<allPassProvider>().Password[index], index.toString());
                                                context.read<allPassProvider>().addSocial(index);
                                                Fluttertoast.showToast(msg: "Account added!");
                                              } else{
                                                Fluttertoast.showToast(msg: "Account already on Social!");
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
                      ),)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
