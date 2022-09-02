import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mpass/providers/WorkProvider.dart';
import 'package:provider/provider.dart';

import '../providers/allPassProvider.dart';

class workDialog extends StatefulWidget {
  const workDialog({Key? key}) : super(key: key);

  @override
  State<workDialog> createState() => _workDialogState();
}

class _workDialogState extends State<workDialog> {


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
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 500,
          child: Column(
            children: [
              Text("Social Accounts"),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: context.watch<workProvider>().Title.length,
                    shrinkWrap: true,
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
                            context.read<workProvider>().deleteAllPass(index);
                          },
                          icon: Text("-", style: TextStyle(fontWeight: FontWeight.bold),),
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                        ),
                      );
                    }),
              ),
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
                            height: 400,
                            child: Column(
                              children: [
                                const Text("Add to Social Category"),
                                ListView.builder(
                                    shrinkWrap:  true,
                                    itemCount: context.watch<allPassProvider>().Title.length,
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
                                            context.read<workProvider>().addWork(context.read<allPassProvider>().Title[index],context.read<allPassProvider>().Email[index], context.read<allPassProvider>().Password[index]);
                                          },
                                          icon: Icon(Icons.add),
                                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  child: const Text("Add Account")
              )
            ],
          ),
        ),
      ),
    );;
  }
}
