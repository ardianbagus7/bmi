part of '../../week4.dart';

class ProfilPage4 extends StatefulWidget {
  @override
  _ProfilPage4State createState() => _ProfilPage4State();
}

class _ProfilPage4State extends State<ProfilPage4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AuthProvider4>(
          builder: (BuildContext context, provider, child) {
            return Padding(
              padding: headerPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/hackaton-imhf.appspot.com/o/login.png?alt=media&token=d359bfd1-db76-4452-8e41-3a37f5a13d17'),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text(
                      '${provider.user.name} ',
                      style: blackTextFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                       Text(
                      '${provider.user.email} ',
                      style: blackTextFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {},
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
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ],
    );
  }
}
