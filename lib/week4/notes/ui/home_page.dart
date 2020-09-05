part of '../../week4.dart';

class HomePage4 extends StatefulWidget {
  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  Flushbar flush = Flushbar();
  RandomColor randomColor = RandomColor();

  ///
  /// Methods
  ///
  void getNotes() async {
    flush.dismiss(true);
    NoteResult result =
        await Provider.of<NoteProvider>(context, listen: false).getNotes();

    if (result.data == null) {
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: getNotes,
          child: Text(
            'Refresh',
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      )..show(context);
    }
  }

  void logOut() {
    Navigator.pop(context);
    Provider.of<AuthProvider4>(context, listen: false).logOut();
  }

  ///
  /// Lifecycle
  ///
  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  void didChangeDependencies(){
    Provider.of<NoteProvider>(context, listen: false).clear();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                            child: GestureDetector(
                          onTap: logOut,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: colorMain,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text('Sign out',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ));
                      },
                    );
                  },
                ),
                Text(
                  'My Notes',
                  style: blackTextFont.copyWith(
                      fontSize: 20,
                      color: colorMain,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Consumer<NoteProvider>(
              builder: (BuildContext context, provider, child) {
                if (provider.notes != null) {
                  return Expanded(
                    child: Container(
                      padding: headerPadding,
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: provider.notes.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () async {
                            String result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailNotePage(note: provider.notes[index]),
                              ),
                            );
                            if (result != null) {
                              Flushbar(
                                duration: Duration(milliseconds: 2000),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: colorMain,
                                message: result,
                              )..show(context);
                              getNotes();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: colorBg,
                            ),
                            padding: headerPadding,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.notes[index].judul,
                                  style: blackTextFont.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorMain,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                    provider.notes[index].deskripsi,
                                    overflow: TextOverflow.fade,
                                    style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ' ${timeAgoIndo(provider.notes[index].createdAt)}',
                                  style: blackTextFont.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(
                          2,
                          provider.notes[index].deskripsi.length > 40
                              ? 3
                              : provider.notes[index].deskripsi.length > 10 &&
                                      provider.notes[index].deskripsi.length <
                                          40
                                  ? 2
                                  : 1.5,
                        ),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorMain,
          child: Icon(Icons.add),
          onPressed: () async {
            String result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateNotePage(),
              ),
            );
            if (result != null) {
              Flushbar(
                duration: Duration(milliseconds: 2000),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: colorMain,
                message: result,
              )..show(context);
              getNotes();
            }
          }),
    );
  }
}
